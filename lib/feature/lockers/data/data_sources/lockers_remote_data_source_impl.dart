import 'package:dio/dio.dart';
import 'package:dnsc_locker/core/constant/api_path.dart';
import 'package:dnsc_locker/core/constant/api_response_models.dart';
import 'package:dnsc_locker/core/constant/non_paginated_api_response_models.dart';
import 'package:dnsc_locker/feature/lockers/data/data_sources/lockers_remote_data_source.dart';
import 'package:dnsc_locker/feature/lockers/data/models/locker_models.dart';
import 'package:flutter/material.dart';

class LockersRemoteDataSourceImpl implements LockersRemoteDataSource {
  final Dio dio;

  LockersRemoteDataSourceImpl(this.dio);

  /*
    Fetching of all lockers, regardless of availability
  */
  @override
  Future<ApiResponseModels<LockerModels>> getLockers({
    required int page,
  }) async {
    try {
      final response = await dio.get(
        ApiPath.lockers,
        queryParameters: {'current_page': page},
      );

      print("PAGINATED DATA: ${response.data['data']}");

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
    throw Exception('Something is wrong!');
  }

  /*
    Fetching of available lockers that has not been yet rented.
  */
  @override
  Future<NonPaginatedApiResponseModels<LockerModels>>
  getAvailableLockersByFilter({
    required String academicYear,
    int? building,
    required String semester,
  }) async {
    try {
      final response = await dio.get(
        ApiPath.lockersAvailable,
        queryParameters: {
          "academic_year": academicYear,
          if (building != null) "building": building,
          "semester": semester,
        },
      );

      print(
        "AVAILABLE LOCKERS FOR $academicYear | $semester: ${response.data}",
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final results = NonPaginatedApiResponseModels.fromJson(
          // We did not use response.data['data'] due to a different
          // API response and it is not paginated
          response.data,
          (json) => LockerModels.fromJson(json),
        );

        return results;
      }
    } on DioException catch (e, stack) {
      print('Fetching available lockers failed: $e');
      debugPrintStack(stackTrace: stack);
    }
    throw Exception("Something is wrong fetching available lockers");
  }
}
