import 'package:dnsc_locker/core/constant/api_response_models.dart';
import 'package:dnsc_locker/core/constant/non_paginated_api_response_models.dart';
import 'package:dnsc_locker/feature/lockers/data/models/locker_models.dart';

abstract class LockersRemoteDataSource {
  Future<ApiResponseModels<LockerModels>> getLockers({required int page});
  Future<NonPaginatedApiResponseModels<LockerModels>>
  getAvailableLockersByFilter({
    required String academicYear,
    int building,
    required String semester,
  });
}
