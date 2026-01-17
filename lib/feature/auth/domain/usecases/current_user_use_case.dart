import 'package:dnsc_locker/feature/auth/domain/entities/user_entity.dart';
import 'package:dnsc_locker/feature/auth/domain/repo/auth_repository.dart';

class CurrentUserUseCase {
  final AuthRepository authRepo;

  CurrentUserUseCase({required this.authRepo});

  Future<UserEntity?> call() {
    return authRepo.loadUserProfile();
  }
}
