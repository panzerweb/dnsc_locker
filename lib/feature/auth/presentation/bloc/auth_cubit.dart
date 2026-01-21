import 'package:dnsc_locker/feature/auth/domain/usecases/current_user_use_case.dart';
import 'package:dnsc_locker/feature/auth/domain/usecases/login_use_case.dart';
import 'package:dnsc_locker/feature/auth/domain/usecases/logout_use_case.dart';
import 'package:dnsc_locker/feature/auth/domain/usecases/register_use_case.dart';
import 'package:dnsc_locker/feature/auth/presentation/bloc/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  final LoginUseCase loginUseCase;
  final RegisterUseCase registerUseCase;
  final LogoutUseCase logoutUseCase;
  final CurrentUserUseCase currentUser;

  AuthCubit({
    required this.loginUseCase,
    required this.registerUseCase,
    required this.logoutUseCase,
    required this.currentUser,
  }) : super(AuthInitial());

  Future<void> login(String username, String password) async {
    emit(AuthLoading());

    try {
      final success = await loginUseCase(username, password);

      if (success) {
        emit(AuthAuthenticated());
        loadCurrentProfile();
      } else {
        emit(AuthError('Invalid username or password'));
      }
    } catch (e) {
      emit(AuthError('Login failed. Please try again.'));
    }
  }

  Future<void> register(
    String username,
    String password,
    String email,
    String? firstName,
    String? lastName,
    int instituteId,
  ) async {
    emit(AuthLoading());

    try {
      final success = await registerUseCase(
        username,
        password,
        email,
        firstName,
        lastName,
        instituteId,
      );

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

  Future<void> loadCurrentProfile() async {
    if (state is AuthenticatedUserLoaded) return;

    emit(AuthLoading());

    try {
      final user = await currentUser();

      if (user == null) {
        emit(AuthError('User is not found'));
        return;
      } else {
        emit(AuthenticatedUserLoaded(user));
      }
    } catch (e) {
      print(e);
      emit(AuthError('User fetching error: $e'));
    }
  }
}
