import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dnsc_locker/core/constant/api_path.dart';
import 'package:dnsc_locker/core/services/token_service.dart';
import 'package:dnsc_locker/feature/auth/data/data_source/auth_remote_datasource.dart';
import 'package:dnsc_locker/feature/auth/data/models/user_model.dart';
import 'package:flutter/widgets.dart';

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
        options: Options(extra: {'requiresAuth': false}),
      );

      print(jsonEncode(response.data));

      final data = response.data['data'];
      final token = data?['access'];

      if (response.statusCode == 200 && token != null) {
        await tokenStorage.saveToken(token);
        return true;
      }

      return false;
    } on DioException catch (e, stack) {
      print('Login failed: $e');
      debugPrintStack(stackTrace: stack);
      return false;
    }
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
    try {
      final response = await dio.post(
        ApiPath.register,
        data: {
          'username': username,
          'password': password,
          'email': email,
          'first_name': firstName,
          'last_name': lastName,
          'institute': instituteId,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final token = response.data; // Ensure this matches your API response
        if (token != null) {
          await tokenStorage.saveToken(token);
          return true;
        }
      }
    } on DioException catch (e) {
      print('Signup error: ${e.response?.data}');
    }
    return false;
  }

  @override
  Future<UserModel?> loadUserProfile() async {
    try {
      final response = await dio.get(ApiPath.currentLoggedUser);

      final data = response.data['data'];
      if (data == null) return null;

      return UserModel.fromJson(data);
    } on DioException catch (e) {
      print('Fetching user profile failed: ${e.response?.data}');
      return null;
    }
  }
}
