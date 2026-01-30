import 'package:dio/dio.dart';
import 'package:dnsc_locker/core/constant/api_path.dart';
import 'package:dnsc_locker/core/constant/api_response_models.dart';
import 'package:dnsc_locker/feature/lockers/data/data_sources/lockers_remote_data_source.dart';
import 'package:dnsc_locker/feature/lockers/data/models/locker_models.dart';
import 'package:flutter/material.dart';

class LockersRemoteDataSourceImpl implements LockersRemoteDataSource {
  final Dio dio;

  LockersRemoteDataSourceImpl(this.dio);

  @override
  Future<ApiResponseModels<LockerModels>> getLockers({
    required int page,
  }) async {
    try {
      final response = await dio.get(
        ApiPath.lockers,
        queryParameters: {'current_page': page},
      );

      print(response.data);

      if (response.statusCode == 200 || response.statusCode == 201) {
        // API has nested data -> response.data['data']
        final paginatedData = ApiResponseModels.fromJson(
          response.data['data'],
          (json) => LockerModels.fromJson(json),
        );
        return paginatedData;
      }
    } on DioException catch (e, stack) {
      print('Fetching lockers failed: $e');
      debugPrintStack(stackTrace: stack);
    }
    throw Exception('Failed to fetch lockers');
  }
}
