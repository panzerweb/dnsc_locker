import 'package:dnsc_locker/feature/auth/domain/repo/auth_repository.dart';

class RegisterUseCase {
  final AuthRepository authRepo;

  RegisterUseCase({required this.authRepo});

  Future<bool> call(String username, String password) async {
    return await authRepo.register(username, password);
  }
}
