/*
  This will be the entity for the POST Request body
*/

class LockerSubscriptionRequestCreateEntity {
  final int lockerId;
  final String academicYear;
  final String semester;

  LockerSubscriptionRequestCreateEntity({
    required this.lockerId,
    required this.academicYear,
    required this.semester,
  });
}
