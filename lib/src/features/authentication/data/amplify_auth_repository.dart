import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:my_amplify_app/src/utils/in_memory_store.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'amplify_auth_repository.g.dart';

class AmplifyAuthRepository {
  final _authState = InMemoryStore<List<AuthUserAttribute>?>(null);

  Stream<List<AuthUserAttribute>?> authStateChanges() => _authState.stream;
  List<AuthUserAttribute>? get currentUser => _authState.value;

  Future<List<AuthUserAttribute>> fetchCurrentUser() async {
    try {
      var currentUser = await Amplify.Auth.fetchUserAttributes();
      _authState.value = currentUser;
      debugPrint('@@@@@authStatus:in repo${currentUser.isNotEmpty.toString()}');
      return currentUser;
    } on AuthException catch (e) {
      debugPrint('${e.message} ####');
      return Future.value([]);
      // throw Exception(e.message);
    }
  }

  Future<bool> isSignedInStatus() async {
    try {
      var currentUser = await Amplify.Auth.fetchUserAttributes();
      _authState.value = currentUser;

      return currentUser.isNotEmpty;
    } on AuthException catch (e) {
      debugPrint('authStatus:in rep false');
      debugPrint(e.message);
      return false;
    }
  }

  Future<bool> signIn(String email, String password) async {
    try {
      final result =
          await Amplify.Auth.signIn(username: email, password: password);
      if (result.isSignedIn) {
        _authState.value = await fetchCurrentUser();
      }
      if (result.nextStep.signInStep == AuthSignInStep.confirmSignUp) {}
      debugPrint('${result.isSignedIn} ${result.nextStep.toJson()} ####');

      return result.isSignedIn;
    } on AuthException catch (e) {
      // Handle signIn error
      debugPrint('${e.message} ####');

      throw Exception(e.message);
    }
  }

  Future<void> signUp(
    String username,
    String email,
    String password,
  ) async {
    try {
      final result = await Amplify.Auth.signUp(
        username: username,
        password: password,
        options: SignUpOptions(userAttributes: {
          AuthUserAttributeKey.email: email,
          AuthUserAttributeKey.name: username
        }),
      );
      if (result.isSignUpComplete) {
        signIn(email, password);
      }
    } on AuthException catch (e) {
      debugPrint('${e.message} ####');
      throw Exception(e.message);
    }
  }

  Future<void> signUpConfirm(String username, String confirmationCode) async {
    try {
      final result = await Amplify.Auth.confirmSignUp(
        username: username,
        confirmationCode: confirmationCode,
      );

      debugPrint('Sign up confirmed: $result');
    } on AuthException catch (e) {
      debugPrint('Confirmation failed: ${e.message}');
      throw Exception(e.message);
    }
  }

  Future<void> signOut() async {
    try {
      await Amplify.Auth.signOut();
      await fetchCurrentUser();
      await isSignedInStatus();
      _authState.value = null;
    } on AuthException catch (e) {
      debugPrint(e.message);
      throw Exception(e.message);
    }
  }
}

@Riverpod(keepAlive: true)
AmplifyAuthRepository amplifyAuth(AmplifyAuthRef ref) {
  return AmplifyAuthRepository();
}

@riverpod
Future<Map<String, String>> currentUserInfo(CurrentUserInfoRef ref) async {
  final amplifyRepository = ref.watch(amplifyAuthProvider);
  final Map<String, String> _userAttributes = {};

  final userAttributes = await amplifyRepository.fetchCurrentUser();
  for (var attribute in userAttributes) {
    _userAttributes[attribute.userAttributeKey.toString()] = attribute.value;
  }
  return _userAttributes;
}

@Riverpod(keepAlive: true)
Stream<List<AuthUserAttribute>?> authStateChanges(AuthStateChangesRef ref) {
  final authRepository = ref.watch(amplifyAuthProvider);
  return authRepository.authStateChanges();
}

@Riverpod(keepAlive: true)
Future<bool> isSignedInStatus(IsSignedInStatusRef ref) async {
  final amplifyRepository = ref.watch(amplifyAuthProvider);
  var isSignedIn = await amplifyRepository.isSignedInStatus();
  return isSignedIn;
}

@Riverpod(keepAlive: true)
Future<List<AuthUserAttribute>> fetchUserInfo(FetchUserInfoRef ref) async {
  final amplifyRepository = ref.watch(amplifyAuthProvider);
  var userInfo = await amplifyRepository.fetchCurrentUser();
  return userInfo;
}
