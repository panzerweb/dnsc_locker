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

class UserEntity {
  final String username;
  final String email;
  final String? first_name;
  final String? last_name;
  final InstituteEntity? institute;
  final int? profile;

  UserEntity({
    required this.username,
    required this.email,
    this.first_name,
    this.last_name,
    this.institute,
    this.profile,
  });
}
