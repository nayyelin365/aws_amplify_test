import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'amplify_auth_repository.g.dart';

class AmplifyAuthRepository {
  Future<List<AuthUserAttribute>> fetchCurrentUser() async {
    var currentUser = await Amplify.Auth.fetchUserAttributes();

    debugPrint(currentUser.length.toString() + "####");
    return currentUser;
  }

  Future<bool> signIn(String email, String password) async {
    try {
      final isLogin =
          await Amplify.Auth.signIn(username: email, password: password);
      return isLogin.isSignedIn;
    } on AuthException catch (e) {
      // Handle signIn error
      debugPrint(e.message);
      return false;
    }
  }

  Future<void> signUp(
    String email,
    String password,
  ) async {
    try {
      await Amplify.Auth.signUp(username: email, password: password);
    } on AuthException catch (e) {
      debugPrint(e.message);
    }
  }

  Future<void> signOut() async {
    try {
      await Amplify.Auth.signOut();
    } on AuthException catch (e) {
      debugPrint(e.message);
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
