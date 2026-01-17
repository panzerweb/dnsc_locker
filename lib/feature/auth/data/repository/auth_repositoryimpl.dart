import 'package:dnsc_locker/core/services/token_service.dart';
import 'package:dnsc_locker/feature/auth/data/data_source/auth_remote_datasource.dart';
import 'package:dnsc_locker/feature/auth/domain/entities/user_entity.dart';
import 'package:dnsc_locker/feature/auth/domain/repo/auth_repository.dart';

class AuthRepositoryimpl implements AuthRepository {
  final AuthRemoteDatasource remote;
  final TokenService tokenStorage;

  AuthRepositoryimpl(this.remote, this.tokenStorage);

  @override
  Future<bool> login(String username, String password) async {
    return await remote.login(username, password);
  }

  @override
  Future<bool> register(
    String username,
    String password,
    String email,
    String? firstName,
    String? lastName,
    int instituteId,
  ) async {
    return await remote.register(
      username,
      password,
      email,
      firstName,
      lastName,
      instituteId,
    );
  }

  @override
  Future<void> logout() async {
    await tokenStorage.deleteToken();
  }

  @override
  Future<UserEntity?> loadUserProfile() async {
    final user = await remote.loadUserProfile();
    return user?.toEntity();
  }
}
