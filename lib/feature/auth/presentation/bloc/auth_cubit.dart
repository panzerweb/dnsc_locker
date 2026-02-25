import 'package:dnsc_locker/core/constant/auth_error_state.dart';
import 'package:dnsc_locker/core/services/service_locator.dart';
import 'package:dnsc_locker/core/services/token_service.dart';
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
      }
    } on AuthErrorState catch (e) {
      emit(AuthError(e.message));
    } catch (_) {
      emit(AuthError('Unexpected error. Please try again.'));
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

  /*
    This Cubit method loads the current profile
  */
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

  /*
    Acts as a guard that checks if the app has an authenticated
    user via token

    If there is none, then do not execute loadCurrentProfile()
  */
  Future<void> checkIfAuthenticated() async {
    final tokenService = locator<TokenService>();
    final token = await tokenService.getToken();

    if (token == null) {
      emit(AuthUnauthenticated());
      return;
    }

    try {
      await loadCurrentProfile();
    } catch (e) {
      emit(AuthUnauthenticated());
      emit(AuthError("Checking authentication failed: $e"));
    }
  }
}
