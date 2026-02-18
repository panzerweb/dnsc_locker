import 'package:dnsc_locker/core/constant/non_paginated_api_response_entity.dart';
import 'package:dnsc_locker/feature/lockers/domain/entities/locker_entity.dart';
import 'package:dnsc_locker/feature/lockers/domain/repository/locker_repository.dart';

class FilterLockersUseCase {
  final LockerRepository lockerRepo;

  FilterLockersUseCase(this.lockerRepo);

  Future<NonPaginatedApiResponseEntity<LockerEntity>> call({
    required String academicYear,
    int? building,
    required String semester,
  }) async {
    final result = await lockerRepo.getAvailableLockers(
      academicYear: academicYear,
      semester: semester,
    );

    return result;
  }
}
