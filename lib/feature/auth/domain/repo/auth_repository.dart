import 'package:dnsc_locker/feature/auth/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<bool> login(String username, String password);
  Future<bool> register(
    String username,
    String password,
    String email,
    String? firstName,
    String? lastName,
    int instituteId,
  );
  Future<void> logout();
  Future<UserEntity?> loadUserProfile();
}
