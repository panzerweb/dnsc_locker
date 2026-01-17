class SchoolEntity {
  final int id;
  final String schoolName;
  final String shortName;
  final String? logo;
  final String location;
  final String createdAt;
  final String updatedAt;
  final int? updatedBy;

  SchoolEntity({
    required this.id,
    required this.schoolName,
    required this.shortName,
    this.logo,
    required this.location,
    required this.createdAt,
    required this.updatedAt,
    this.updatedBy,
  });
}
