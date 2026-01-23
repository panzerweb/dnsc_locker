class InstituteEntity {
  final int id;
  final String instituteName;
  final String? logo;

  InstituteEntity({required this.id, required this.instituteName, this.logo});

  // remove fromJSON and toJSON from all entities once
  // You apply real dynamic data using clean architecture
  factory InstituteEntity.fromJson(Map<String, dynamic> json) {
    return InstituteEntity(
      id: json['id'] as int,
      instituteName: json['institute_name'] as String,
      logo: json['logo'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'institute_name': instituteName, 'logo': logo};
  }

  @override
  String toString() => 'InstituteEntity(id: $id, name: $instituteName)';
}
