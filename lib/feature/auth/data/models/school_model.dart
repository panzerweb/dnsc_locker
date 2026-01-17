import 'package:dnsc_locker/feature/auth/domain/entities/school_entity.dart';

class SchoolModel {
  final int id;
  final String schoolName;
  final String shortName;
  final String? logo;
  final String location;
  final String createdAt;
  final String updatedAt;
  final int? updatedBy;

  SchoolModel({
    required this.id,
    required this.schoolName,
    required this.shortName,
    this.logo,
    required this.location,
    required this.createdAt,
    required this.updatedAt,
    this.updatedBy,
  });

  factory SchoolModel.fromJson(Map<String, dynamic> json) {
    return SchoolModel(
      id: json['id'] as int,
      schoolName: json['school_name'] as String,
      shortName: json['short_name'] as String,
      logo: json['logo'] as String?,
      location: json['location'] as String,
      createdAt: json['created_at'] as String,
      updatedAt: json['updated_at'] as String,
      updatedBy: json['updated_by'] as int?,
    );
  }

  SchoolEntity toEntity() {
    return SchoolEntity(
      id: id,
      schoolName: schoolName,
      shortName: shortName,
      logo: logo,
      location: location,
      createdAt: createdAt,
      updatedAt: updatedAt,
      updatedBy: updatedBy,
    );
  }
}
