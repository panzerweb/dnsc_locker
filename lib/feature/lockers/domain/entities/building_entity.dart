/*
  API Response:

  "building": {
        "id": 0,
        "school_name":
          "name": "IC Building",
          "max_floor": 2
        },
*/
class BuildingEntity {
  final int id;
  final String schoolName;
  final String name;
  final int maxFloor;

  const BuildingEntity({
    required this.id,
    required this.schoolName,
    required this.name,
    required this.maxFloor,
  });

  @override
  String toString() => name;
}
