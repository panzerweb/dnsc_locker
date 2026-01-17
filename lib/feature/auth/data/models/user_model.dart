import 'package:dnsc_locker/feature/auth/data/models/institute_model.dart';
import 'package:dnsc_locker/feature/auth/domain/entities/user_entity.dart';

class UserModel {
  final String username;
  final String email;
  final String? first_name;
  final String? last_name;
  final InstituteModel? institute;
  final int? profile;

  UserModel({
    required this.username,
    required this.email,
    this.first_name,
    this.last_name,
    required this.institute,
    this.profile,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      username: json['username'] as String,
      email: json['email'] as String,
      first_name: json['first_name'] as String?,
      last_name: json['last_name'] as String?,
      institute: json['institute'] != null
          ? InstituteModel.fromJson(json['institute'])
          : null,
      profile: json['profile'] as int?,
    );
  }

  UserEntity toEntity() {
    return UserEntity(
      username: username,
      email: email,
      first_name: first_name,
      last_name: last_name,
      institute: institute?.toEntity(),
      profile: profile,
    );
  }
}
