import 'package:dnsc_locker/feature/auth/domain/entities/student_entity.dart';

class StudentModel {
  final int id;
  final String programName;
  final String studentId;
  final String rfid;
  final String firstName;
  final String middleName;
  final String lastName;
  final String suffix;
  final String studentSet;
  final int studentLevel;
  final String studentStatus;
  final String? studentImage;
  final int program;
  final int user;

  StudentModel({
    required this.id,
    required this.programName,
    required this.studentId,
    required this.rfid,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.suffix,
    required this.studentSet,
    required this.studentLevel,
    required this.studentStatus,
    this.studentImage,
    required this.program,
    required this.user,
  });

  factory StudentModel.fromJson(Map<String, dynamic> json) {
    return StudentModel(
      id: json['id'],
      programName: json['program_name'],
      studentId: json['s_studentID'],
      rfid: json['s_rfid'],
      firstName: json['s_fname'],
      middleName: json['s_mname'],
      lastName: json['s_lname'],
      suffix: json['s_suffix'],
      studentSet: json['s_set'],
      studentLevel: json['s_lvl'],
      studentStatus: json['s_status'],
      studentImage: json['s_image'] as String?,
      program: json['program'],
      user: json['user'],
    );
  }

  StudentEntity toEntity() {
    return StudentEntity(
      id: id,
      programName: programName,
      studentId: studentId,
      rfid: rfid,
      firstName: firstName,
      middleName: middleName,
      lastName: lastName,
      suffix: suffix,
      studentSet: studentSet,
      studentLevel: studentLevel,
      studentStatus: studentStatus,
      studentImage: studentImage?.isEmpty == true ? null : studentImage,
      program: program,
      user: user,
    );
  }
}
