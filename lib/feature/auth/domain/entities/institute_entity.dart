import 'package:dnsc_locker/feature/auth/domain/entities/school_entity.dart';

/*
  Expected API response

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
      },
      "created_at": "2025-10-13T13:29:56.191837Z",
      "updated_at": "2025-10-13T13:29:56.191837Z",
      "institute_name": "Insiture of Computing",
      "logo": "yesss",
      "updated_by": 1
    },
*/
class InstituteEntity {
  final int id;
  final SchoolEntity? school;
  final String createdAt;
  final String updatedAt;
  final String instituteName;
  final String? logo;

  InstituteEntity({
    required this.id,
    this.school,
    required this.createdAt,
    required this.updatedAt,
    required this.instituteName,
    this.logo,
  });
}
