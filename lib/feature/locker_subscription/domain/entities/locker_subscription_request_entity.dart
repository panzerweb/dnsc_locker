import 'package:dnsc_locker/feature/auth/domain/entities/student_entity.dart';
import 'package:dnsc_locker/feature/lockers/domain/entities/locker_entity.dart';

/*
  This will the entity for the endpoints which supports GET methods
*/
class LockerSubscriptionRequestEntity {
  final int id;
  final StudentEntity? student;
  final LockerEntity? locker;
  final String academicYear;
  final String semester;
  final String status;

  LockerSubscriptionRequestEntity({
    required this.id,
    required this.student,
    required this.locker,
    required this.academicYear,
    required this.semester,
    required this.status,
  });
}
