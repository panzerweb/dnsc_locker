import 'package:dnsc_locker/feature/lockers/data/models/building_models.dart';
import 'package:dnsc_locker/feature/lockers/domain/entities/locker_entity.dart';

class LockerModels {
  final int id;
  final BuildingModels? building;
  final String lockerNumber;
  final int floor;
  final bool isActive;

  LockerModels({
    required this.id,
    this.building,
    required this.lockerNumber,
    required this.floor,
    required this.isActive,
  });

  factory LockerModels.fromJson(Map<String, dynamic> json) {
    return LockerModels(
      id: json['id'] as int,
      building: json['building'] != null
          ? BuildingModels.fromJson(json['building'])
          : null,
      lockerNumber: json['locker_number'] as String,
      floor: json['floor'] as int,
      isActive: json['is_active'] as bool,
    );
  }

  LockerEntity toEntity() {
    return LockerEntity(
      id: id,
      building: building!.toEntity(),
      lockerNumber: lockerNumber,
      floor: floor,
      isActive: isActive,
    );
  }
}
