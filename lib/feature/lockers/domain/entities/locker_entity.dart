import 'package:dnsc_locker/feature/lockers/domain/entities/building_entity.dart';

/*
  Locker fields:

  id
  lockerNo
  building
  is_rented - is the locker currently rented
  status -  is the locker on good condition
  created_at
  updated_at
*/
class LockerEntity {
  final int id;
  final String lockerNo;
  final BuildingEntity building;
  final int isRented;
  final int status;

  LockerEntity({
    required this.id,
    required this.lockerNo,
    required this.building,
    required this.isRented,
    required this.status,
  });

  // remove fromJSON and toJSON from all entities once
  // You apply real dynamic data using clean architecture

  factory LockerEntity.fromJson(Map<String, dynamic> json) {
    return LockerEntity(
      id: json['id'] as int,
      lockerNo: json['locker_no'] as String,
      building: BuildingEntity.fromJson(
        json['building'] as Map<String, dynamic>,
      ),
      isRented: json['is_rented'] as int,
      status: json['status'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'locker_no': lockerNo,
      'building': building.toJson(),
      'isRented': isRented,
      'status': status,
    };
  }

  @override
  String toString() =>
      'Locker(id: $id, lockerNo: $lockerNo, institute: ${building.institute?.instituteName})';
}
