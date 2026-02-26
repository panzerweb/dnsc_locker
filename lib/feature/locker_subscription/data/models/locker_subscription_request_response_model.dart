import 'package:dnsc_locker/feature/locker_subscription/domain/entities/locker_subscription_request_response_entity.dart';

class LockerSubscriptionRequestResponseModel {
  final int lockerId;
  final String academicYear;
  final String semester;

  LockerSubscriptionRequestResponseModel({
    required this.lockerId,
    required this.academicYear,
    required this.semester,
  });

  factory LockerSubscriptionRequestResponseModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return LockerSubscriptionRequestResponseModel(
      lockerId: json['locker'],
      academicYear: json['academic_year'],
      semester: json['semester'],
    );
  }

  LockerSubscriptionRequestResponseEntity toEntity() {
    return LockerSubscriptionRequestResponseEntity(
      lockerId: lockerId,
      academicYear: academicYear,
      semester: semester,
    );
  }
}
