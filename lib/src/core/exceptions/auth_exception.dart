sealed class AuthException implements Exception {
  final String message;
  AuthException({required this.message});
}

class AuthError extends AuthException {
  @override
  AuthError({required super.message});
}

class UnauthorizedAuthException extends AuthException {
  @override
  UnauthorizedAuthException({required super.message});
}
