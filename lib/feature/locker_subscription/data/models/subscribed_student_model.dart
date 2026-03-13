import 'package:dnsc_locker/feature/locker_subscription/domain/entities/subscribed_student_entity.dart';

class SubscribedStudentModel {
  final int id;
  final String fullName;
  final String programName;
  final String studentSet;
  final int studentLevel;

  SubscribedStudentModel({
    required this.id,
    required this.fullName,
    required this.programName,
    required this.studentSet,
    required this.studentLevel,
  });

  factory SubscribedStudentModel.fromJson(Map<String, dynamic> json) {
    return SubscribedStudentModel(
      id: json['id'],
      fullName: json['full_name'],
      programName: json['program_name'],
      studentSet: json['s_set'],
      studentLevel: json['s_lvl'],
    );
  }

  SubscribedStudentEntity toEntity() {
    return SubscribedStudentEntity(
      id: id,
      fullName: fullName,
      programName: programName,
      studentSet: studentSet,
      studentLevel: studentLevel,
    );
  }
}
