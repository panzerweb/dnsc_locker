import 'package:dnsc_locker/feature/auth/domain/repo/auth_repository.dart';

class LogoutUseCase {
  final AuthRepository authRepo;

  LogoutUseCase(this.authRepo);

  Future<void> call() async {
    await authRepo.logout();
  }
}
