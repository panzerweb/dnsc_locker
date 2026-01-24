import 'package:dnsc_locker/feature/lockers/domain/entities/building_entity.dart';

class BuildingModels {
  final String name;
  final int maxFloor;

  BuildingModels({required this.name, required this.maxFloor});

  factory BuildingModels.fromJson(Map<String, dynamic> json) {
    return BuildingModels(name: json['name'], maxFloor: json['max_floor']);
  }

  BuildingEntity toEntity() {
    return BuildingEntity(name: name, maxFloor: maxFloor);
  }
}
