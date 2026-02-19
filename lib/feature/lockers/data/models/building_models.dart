import 'package:dnsc_locker/feature/lockers/domain/entities/building_entity.dart';

class BuildingModels {
  final int id;
  final String schoolName;
  final String name;
  final int maxFloor;

  BuildingModels({
    required this.name,
    required this.maxFloor,
    required this.id,
    required this.schoolName,
  });

  factory BuildingModels.fromJson(Map<String, dynamic> json) {
    return BuildingModels(
      id: json['id'],
      schoolName: json['school_name'],
      name: json['name'],
      maxFloor: json['max_floor'],
    );
  }

  BuildingEntity toEntity() {
    return BuildingEntity(
      id: id,
      schoolName: schoolName,
      name: name,
      maxFloor: maxFloor,
    );
  }
}
