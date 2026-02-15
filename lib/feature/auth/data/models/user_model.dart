import 'package:dnsc_locker/feature/auth/data/models/institute_model.dart';
import 'package:dnsc_locker/feature/auth/data/models/student_model.dart';
import 'package:dnsc_locker/feature/auth/domain/entities/user_entity.dart';

class UserModel {
  final InstituteModel? institute;
  final String username;
  final String? firstName;
  final String? lastName;
  final String email;
  final String? profile;
  final StudentModel? student;
  final List<String> groups;

  UserModel({
    this.institute,
    required this.username,
    this.firstName,
    this.lastName,
    required this.email,
    this.profile,
    this.student,
    required this.groups,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      institute: json['institute'] != null
          ? InstituteModel.fromJson(json['institute'])
          : null,
      username: json['username'] as String,
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      email: json['email'] as String,
      profile: json['profile'] as String?,
      student: json['student'] != null
          ? StudentModel.fromJson(json['student'])
          : null,
      groups: (json['groups'] as List<dynamic>? ?? [])
          .map((e) => e.toString())
          .toList(),
    );
  }

  UserEntity toEntity() {
    return UserEntity(
      institute: institute?.toEntity(),
      username: username,
      firstName: firstName?.isEmpty == true ? null : firstName,
      lastName: lastName?.isEmpty == true ? null : lastName,
      email: email,
      profile: profile,
      student: student?.toEntity(),
      groups: groups,
    );
  }
}
