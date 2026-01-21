import 'package:dnsc_locker/feature/lockers/domain/entities/institute_entity.dart';

class BuildingEntity {
  final String name;
  final int floors;
  final InstituteEntity? institute;

  const BuildingEntity({
    required this.name,
    required this.floors,
    this.institute,
  });

  factory BuildingEntity.fromJson(Map<String, dynamic> json) {
    return BuildingEntity(
      name: json['name'] as String,
      floors: json['floors'] as int,
      institute: json['institute'] != null
          ? InstituteEntity.fromJson(json['institute'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'floors': floors, 'institute': institute?.toJson()};
  }

  @override
  String toString() => 'Building(name: $name)';
}
