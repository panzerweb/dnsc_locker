abstract class AuthRemoteDatasource {
  Future<bool> login(String username, String password);
  Future<bool> register(String username, String password);
}
