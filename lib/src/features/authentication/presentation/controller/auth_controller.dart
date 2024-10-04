import 'package:my_amplify_app/src/features/authentication/data/amplify_auth_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_controller.g.dart';

@riverpod
class AuthController extends _$AuthController {
  @override
  Future<void> build() async {
    // nothing to do
  }

  Future<bool> signIn({required String email, required String password}) async {
    state = const AsyncLoading();
    final amplifyProvider = ref.read(amplifyAuthProvider);
    state =
        await AsyncValue.guard(() => amplifyProvider.signIn(email, password));
    return state.hasError == false;
  }

  Future<bool> signUp(
      {required String username,
      required String email,
      required String password}) async {
    state = const AsyncLoading();
    final amplifyProvider = ref.read(amplifyAuthProvider);
    state = await AsyncValue.guard(
        () => amplifyProvider.signUp(username, email, password));
    return state.hasError == false;
  }

  Future<bool> signUpConfirm(
      {required String username, required String code}) async {
    state = const AsyncLoading();
    final amplifyProvider = ref.read(amplifyAuthProvider);
    state = await AsyncValue.guard(
        () => amplifyProvider.signUpConfirm(username, code));
    return state.hasError == false;
  }

  Future<bool> signOut() async {
    state = const AsyncLoading();
    final amplifyProvider = ref.read(amplifyAuthProvider);
    state = await AsyncValue.guard(() => amplifyProvider.signOut());
    return state.hasError == false;
  }
}
