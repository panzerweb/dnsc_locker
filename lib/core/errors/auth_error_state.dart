class AuthErrorState implements Exception {
  final String message;

  AuthErrorState(this.message);
}

class NetworkFailure extends AuthErrorState {
  NetworkFailure() : super("No internet connection");
}

class InvalidCredentialsFailure extends AuthErrorState {
  InvalidCredentialsFailure() : super("Invalid username or password");
}
