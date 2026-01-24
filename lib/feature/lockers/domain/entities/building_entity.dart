/*
  API Response:

  "building": {
          "name": "IC Building",
          "max_floor": 2
        },
*/
class BuildingEntity {
  final String name;
  final int maxFloor;

  const BuildingEntity({required this.name, required this.maxFloor});

  // remove fromJSON and toJSON from all entities once
  // You apply real dynamic data using clean architecture

  // factory BuildingEntity.fromJson(Map<String, dynamic> json) {
  //   return BuildingEntity(
  //     name: json['name'] as String,
  //     floors: json['floors'] as int,
  //     institute: json['institute'] != null
  //         ? InstituteEntity.fromJson(json['institute'] as Map<String, dynamic>)
  //         : null,
  //   );
  // }

  // Map<String, dynamic> toJson() {
  //   return {'name': name, 'floors': floors, 'institute': institute?.toJson()};
  // }

  // @override
  // String toString() => 'Building(name: $name)';
}
