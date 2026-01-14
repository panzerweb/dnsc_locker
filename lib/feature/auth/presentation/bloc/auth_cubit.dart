import 'package:dnsc_locker/feature/auth/domain/usecases/login_use_case.dart';
import 'package:dnsc_locker/feature/auth/domain/usecases/logout_use_case.dart';
import 'package:dnsc_locker/feature/auth/domain/usecases/register_use_case.dart';
import 'package:dnsc_locker/feature/auth/presentation/bloc/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  final LoginUseCase loginUseCase;
  final RegisterUseCase registerUseCase;
  final LogoutUseCase logoutUseCase;

  AuthCubit({
    required this.loginUseCase,
    required this.registerUseCase,
    required this.logoutUseCase,
  }) : super(AuthInitial());

  Future<void> login(String username, String password) async {
    emit(AuthLoading());

    try {
      final success = await loginUseCase(username, password);

      if (success) {
        emit(AuthAuthenticated());
      } else {
        emit(const AuthError('Invalid username or password'));
      }
    } catch (e) {
      emit(const AuthError('Login failed. Please try again.'));
    }
  }

  Future<void> register(String username, String password) async {
    emit(AuthLoading());

    try {
      final success = await registerUseCase(username, password);

      if (success) {
        emit(AuthAuthenticated());
      } else {
        emit(const AuthError('Registration failed'));
      }
    } catch (e) {
      emit(const AuthError('Registration failed. Please try again.'));
    }
  }

  Future<void> logout() async {
    await logoutUseCase();
    emit(AuthUnauthenticated());
  }
}
