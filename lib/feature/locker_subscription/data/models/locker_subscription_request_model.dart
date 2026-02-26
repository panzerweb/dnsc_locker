import 'package:dnsc_locker/feature/auth/data/models/student_model.dart';
import 'package:dnsc_locker/feature/locker_subscription/domain/entities/locker_subscription_request_entity.dart';
import 'package:dnsc_locker/feature/lockers/data/models/locker_models.dart';

class LockerSubscriptionRequestModel {
  final int id;
  final StudentModel? student;
  final LockerModels? locker;
  final String academicYear;
  final String semester;
  final String status;

  LockerSubscriptionRequestModel({
    required this.id,
    required this.student,
    required this.locker,
    required this.academicYear,
    required this.semester,
    required this.status,
  });

  factory LockerSubscriptionRequestModel.fromJson(Map<String, dynamic> json) {
    return LockerSubscriptionRequestModel(
      id: json['id'],
      student: json['student'] != null
          ? StudentModel.fromJson(json['student'])
          : null,
      locker: json['locker'] != null
          ? LockerModels.fromJson(json['locker'])
          : null,
      academicYear: json['academic_year'],
      semester: json['semester'],
      status: json['status'],
    );
  }

  LockerSubscriptionRequestEntity toEntity() {
    return LockerSubscriptionRequestEntity(
      id: id,
      student: student?.toEntity(),
      locker: locker?.toEntity(),
      academicYear: academicYear,
      semester: semester,
      status: status,
    );
  }
}
