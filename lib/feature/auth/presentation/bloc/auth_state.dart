import 'package:dnsc_locker/feature/auth/domain/entities/user_entity.dart';

abstract class AuthState {
  const AuthState();
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthAuthenticated extends AuthState {}

class AuthUnauthenticated extends AuthState {}

class AuthenticatedUserLoaded extends AuthState {
  final UserEntity user;

  AuthenticatedUserLoaded(this.user);
}

class AuthError extends AuthState {
  final String message;

  const AuthError(this.message);
}
