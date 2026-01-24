import 'package:dnsc_locker/feature/lockers/domain/entities/building_entity.dart';

/*
  Locker fields API response:

{
  "status_code": 200,
  "message": "Success",
  "data": {
    "current_page": 1,
    "per_page": 10,
    "total_pages": 1,
    "total_items": 10,
    "data": [
      {
        "id": 1,
        "building": {
          "name": "IC Building",
          "max_floor": 2
        },
        "locker_number": "1",
        "floor": 1,
        "is_active": true
      },
    ]
  },
  "errors": null
}
*/
class LockerEntity {
  final int id;
  final BuildingEntity building;
  final String lockerNumber;
  final int floor;
  final bool isActive;

  LockerEntity({
    required this.id,
    required this.building,
    required this.lockerNumber,
    required this.floor,
    required this.isActive,
  });

  // remove fromJSON and toJSON from all entities once
  // You apply real dynamic data using clean architecture

  // factory LockerEntity.fromJson(Map<String, dynamic> json) {
  //   return LockerEntity(
  //     id: json['id'] as int,
  //     lockerNo: json['locker_no'] as String,
  //     building: BuildingEntity.fromJson(
  //       json['building'] as Map<String, dynamic>,
  //     ),
  //     isRented: json['is_rented'] as int,
  //     status: json['status'] as int,
  //   );
  // }

  // Map<String, dynamic> toJson() {
  //   return {
  //     'id': id,
  //     'locker_no': lockerNo,
  //     'building': building.toJson(),
  //     'isRented': isRented,
  //     'status': status,
  //   };
  // }

  // @override
  // String toString() =>
  //     'Locker(id: $id, lockerNo: $lockerNo, institute: ${building.institute?.instituteName})';
}
