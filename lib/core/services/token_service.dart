import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/*
  Token handling services

  Handles different token management services within
  the entire application
*/

class TokenService {
  final FlutterSecureStorage _storage = FlutterSecureStorage();

  Future<void> saveToken(String token) async {
    await _storage.write(key: 'jwt', value: token);
  }

  Future<String?> getToken() async {
    return await _storage.read(key: 'jwt');
  }

  Future<void> deleteToken() async {
    await _storage.delete(key: 'jwt');
  }
}
