import 'package:dnsc_locker/feature/auth/domain/repo/auth_repository.dart';

class RegisterUseCase {
  final AuthRepository authRepo;

  RegisterUseCase({required this.authRepo});

  Future<bool> call(
    String username,
    String password,
    String email,
    String? firstName,
    String? lastName,
    int instituteId,
  ) async {
    return await authRepo.register(
      username,
      password,
      email,
      firstName,
      lastName,
      instituteId,
    );
  }
}
