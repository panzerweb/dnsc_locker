import 'package:dnsc_locker/feature/auth/data/models/user_model.dart';

abstract class AuthRemoteDatasource {
  Future<bool> login(String username, String password);
  Future<bool> register(
    String username,
    String password,
    String email,
    String? firstName,
    String? lastName,
    int instituteId,
  );

  Future<UserModel?> loadUserProfile();
}
