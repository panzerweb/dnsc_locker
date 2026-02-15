/*
  Current API response of users endpoint
  Communicate with backend environment for any update
  regarding the API.

  {
    "status_code": 200,
    "message": "Success",
    "data": {
      "institute": {
        "id": 1,
        "school": {
          "id": 1,
          "school_name": "Davao del Norte State College",
          "short_name": "DNSC",
          "logo": "string",
          "location": "Panabo New Visayas DDN",
          "created_at": "2025-10-13T13:29:56.191837Z",
          "updated_at": "2025-10-13T13:29:56.191837Z",
          "updated_by": null
        },
        "created_at": "2025-10-13T13:29:56.191837Z",
        "updated_at": "2025-10-13T13:29:56.191837Z",
        "institute_name": "Insiture of Computing",
        "logo": "yesss",
        "updated_by": 1
      },
      "username": "Panzerweb",
      "first_name": "Panzer",
      "last_name": "Web",
      "email": "panzerweb@gmail.com",
      "profile": null
    },
    "errors": null
  }


*/
import 'package:dnsc_locker/feature/auth/domain/entities/institute_entity.dart';
import 'package:dnsc_locker/feature/auth/domain/entities/student_entity.dart';

class UserEntity {
  final InstituteEntity? institute;
  final String username;
  final String? firstName;
  final String? lastName;
  final String email;
  final String? profile;
  final StudentEntity? student;
  final List<String> groups;

  const UserEntity({
    this.institute,
    required this.username,
    this.firstName,
    this.lastName,
    required this.email,
    this.profile,
    this.student,
    required this.groups,
  });
}
