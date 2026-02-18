import 'package:dnsc_locker/core/constant/api_response_entity.dart';
import 'package:dnsc_locker/core/constant/non_paginated_api_response_entity.dart';
import 'package:dnsc_locker/feature/lockers/domain/entities/locker_entity.dart';

abstract class LockerRepository {
  Future<ApiResponseEntity<LockerEntity>> getLockers(int page);
  Future<NonPaginatedApiResponseEntity<LockerEntity>> getAvailableLockers({
    required String academicYear,
    int building,
    required String semester,
  });
}
