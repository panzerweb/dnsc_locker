import 'package:dnsc_locker/core/constant/simplified_student_entity.dart';

class SimplifiedStudentModel {
  final int id;
  final String fullName;
  final String programName;
  final String studentSet;
  final int studentLevel;

  SimplifiedStudentModel({
    required this.id,
    required this.fullName,
    required this.programName,
    required this.studentSet,
    required this.studentLevel,
  });

  factory SimplifiedStudentModel.fromJson(Map<String, dynamic> json) {
    return SimplifiedStudentModel(
      id: json['id'],
      fullName: json['full_name'],
      programName: json['program_name'],
      studentSet: json['s_set'],
      studentLevel: json['s_lvl'],
    );
  }

  SimplifiedStudentEntity toEntity() {
    return SimplifiedStudentEntity(
      id: id,
      fullName: fullName,
      programName: programName,
      studentSet: studentSet,
      studentLevel: studentLevel,
    );
  }
}
