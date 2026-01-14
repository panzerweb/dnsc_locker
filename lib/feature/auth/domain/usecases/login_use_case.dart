import 'package:dnsc_locker/feature/auth/domain/repo/auth_repository.dart';

class LoginUseCase {
  final AuthRepository authRepo;

  LoginUseCase({required this.authRepo});

  Future<bool> call(String username, String password) async {
    return await authRepo.login(username, password);
  }
}
