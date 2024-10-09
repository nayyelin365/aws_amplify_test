class AppException implements Exception {
  final String message;
  final String code;

  AppException({required this.message, required this.code});

  @override
  String toString() {
    return 'AppException: $message, code: $code';
  }
}

class ConfirmSignInWithNewPasswordException extends AppException {
  ConfirmSignInWithNewPasswordException(
      {required super.message, required super.code});
}

class PasswordLengthNotMatchException extends AppException {
  PasswordLengthNotMatchException(
      {required super.message, required super.code});
}
