import 'package:dnsc_locker/core/constant/simplified_student_model.dart';
import 'package:dnsc_locker/feature/locker_subscription/data/models/fee_model.dart';
import 'package:dnsc_locker/feature/locker_subscription/domain/entities/active_locker_subscription_entity.dart';
import 'package:dnsc_locker/feature/lockers/data/models/locker_models.dart';

class ActiveLockerSubscriptionModel {
  final int id;
  final SimplifiedStudentModel? student;
  final LockerModels? locker;

  final String? subscriptionRequest;
  final String? createdBy;
  final String? cancelledBy;

  final FeeModel? fee;

  final String subscribedAt;
  final String academicYear;
  final String semester;

  final String status;
  final String paymentStatus;

  final String paymentDueAt;

  final String? paidAt;
  final String? cancelledAt;
  final String? cancellationReason;

  ActiveLockerSubscriptionModel({
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

  factory ActiveLockerSubscriptionModel.fromJson(Map<String, dynamic> json) {
    return ActiveLockerSubscriptionModel(
      id: json['id'],
      student: json['student'] != null
          ? SimplifiedStudentModel.fromJson(json['student'])
          : null,
      locker: json['locker'] != null
          ? LockerModels.fromJson(json['locker'])
          : null,
      subscriptionRequest: json['subscription_request'],
      createdBy: json['created_by'],
      cancelledBy: json['cancelled_by'],
      fee: json['fee'] != null ? FeeModel.fromJson(json['fee']) : null,
      subscribedAt: json['subscribed_at'],
      academicYear: json['academic_year'],
      semester: json['semester'],
      status: json['status'],
      paymentStatus: json['payment_status'],
      paymentDueAt: json['payment_due_at'],
      paidAt: json['paid_at'],
      cancelledAt: json['cancelled_at'],
      cancellationReason: json['cancellation_reason'],
    );
  }

  ActiveLockerSubscriptionEntity toEntity() {
    return ActiveLockerSubscriptionEntity(
      id: id,
      student: student?.toEntity(),
      locker: locker?.toEntity(),
      subscriptionRequest: subscriptionRequest,
      createdBy: createdBy,
      cancelledBy: cancelledBy,
      fee: fee?.toEntity(),
      subscribedAt: subscribedAt,
      academicYear: academicYear,
      semester: semester,
      status: status,
      paymentStatus: paymentStatus,
      paymentDueAt: paymentDueAt,
      paidAt: paidAt,
      cancelledAt: cancelledAt,
      cancellationReason: cancellationReason,
    );
  }
}
