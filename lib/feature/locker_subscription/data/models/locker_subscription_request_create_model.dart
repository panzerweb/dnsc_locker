class LockerSubscriptionRequestCreateModel {
  final int? lockerId;
  final String? academicYear;
  final String? semester;

  LockerSubscriptionRequestCreateModel({
    required this.lockerId,
    required this.academicYear,
    required this.semester,
  });

  Map<String, dynamic> toJson() {
    return {
      'locker': lockerId ?? 0,
      'academic_year': academicYear ?? '',
      'semester': semester ?? '',
    };
  }
}
