import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dnsc_locker/core/constant/api_path.dart';
import 'package:dnsc_locker/core/services/token_service.dart';
import 'package:dnsc_locker/feature/auth/data/data_source/auth_remote_datasource.dart';

class AuthRemoteDatasourceimpl implements AuthRemoteDatasource {
  final Dio dio;
  final TokenService tokenStorage;

  AuthRemoteDatasourceimpl(this.dio, this.tokenStorage);

  @override
  Future<bool> login(String username, String password) async {
    try {
      final response = await dio.post(
        ApiPath.login,
        data: jsonEncode({'username': username, 'password': password}),
      );

      print(response.data);

      if (response.statusCode == 200) {
        final token = response
            .data['data']['access']; // Ensure this matches your API response
        if (token != null) {
          await tokenStorage.saveToken(token);
          return true;
        }
      }
    } catch (e) {
      print('Login error: $e');
    }
    return false;
  }

  @override
  Future<bool> register(String username, String password) async {
    try {
      final response = await dio.post(
        ApiPath.register,
        data: jsonEncode({'username': username, 'password': password}),
      );

      if (response.statusCode == 200) {
        final token = response.data; // Ensure this matches your API response
        if (token != null) {
          await tokenStorage.saveToken(token);
          return true;
        }
      }
    } catch (e) {
      print('Signup error: $e');
    }
    return false;
  }
}
