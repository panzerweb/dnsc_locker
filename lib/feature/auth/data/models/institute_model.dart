import 'package:dnsc_locker/feature/auth/data/models/school_model.dart';
import 'package:dnsc_locker/feature/auth/domain/entities/institute_entity.dart';

class InstituteModel {
  final int id;
  final SchoolModel? school;
  final String createdAt;
  final String updatedAt;
  final String instituteName;
  final String? logo;
  final int? updatedBy;

  InstituteModel({
    required this.id,
    this.school,
    required this.createdAt,
    required this.updatedAt,
    required this.instituteName,
    this.logo,
    this.updatedBy,
  });

  factory InstituteModel.fromJson(Map<String, dynamic> json) {
    return InstituteModel(
      id: json['id'] as int,
      school: json['school'] != null
          ? SchoolModel.fromJson(json['school'])
          : null,
      createdAt: json['created_at'] as String,
      updatedAt: json['updated_at'] as String,
      instituteName: json['institute_name'] as String,
      logo: json['logo'] as String?,
      updatedBy: json['updated_by'] as int?,
    );
  }

  InstituteEntity toEntity() {
    return InstituteEntity(
      id: id,
      school: school?.toEntity(),
      instituteName: instituteName,
      createdAt: '',
      updatedAt: '',
      logo: logo,
      updatedBy: updatedBy!,
    );
  }
}
