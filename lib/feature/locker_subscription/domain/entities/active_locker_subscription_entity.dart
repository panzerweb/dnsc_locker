import 'package:dnsc_locker/core/constant/simplified_student_entity.dart';
import 'package:dnsc_locker/feature/locker_subscription/domain/entities/fee_entity.dart';
import 'package:dnsc_locker/feature/lockers/domain/entities/locker_entity.dart';

class ActiveLockerSubscriptionEntity {
  final int id;
  final SimplifiedStudentEntity? student;
  final LockerEntity? locker;

  final String? subscriptionRequest;
  final String? createdBy;
  final String? cancelledBy;

  final FeeEntity? fee;

  final String subscribedAt;
  final String academicYear;
  final String semester;

  final String status;
  final String paymentStatus;

  final String paymentDueAt;

  final String? paidAt;
  final String? cancelledAt;
  final String? cancellationReason;

  ActiveLockerSubscriptionEntity({
    required this.id,
    this.student,
    this.locker,
    this.subscriptionRequest,
    this.createdBy,
    this.cancelledBy,
    this.fee,
    required this.subscribedAt,
    required this.academicYear,
    required this.semester,
    required this.status,
    required this.paymentStatus,
    required this.paymentDueAt,
    this.paidAt,
    this.cancelledAt,
    this.cancellationReason,
  });
}
