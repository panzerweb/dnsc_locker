import 'package:dnsc_locker/feature/lockers/domain/entities/building_entity.dart';

class LockerEntity {
  final int id;
  final String lockerNo;
  final BuildingEntity building;

  LockerEntity({
    required this.id,
    required this.lockerNo,
    required this.building,
  });

  factory LockerEntity.fromJson(Map<String, dynamic> json) {
    return LockerEntity(
      id: json['id'] as int,
      lockerNo: json['locker_no'] as String,
      building: BuildingEntity.fromJson(
        json['building'] as Map<String, dynamic>,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'locker_no': lockerNo, 'building': building.toJson()};
  }

  @override
  String toString() =>
      'Locker(id: $id, lockerNo: $lockerNo, institute: ${building.institute?.instituteName})';
}
