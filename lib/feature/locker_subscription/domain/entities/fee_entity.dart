import 'package:dnsc_locker/feature/auth/domain/entities/student_entity.dart';

class FeeEntity {
  final int id;
  final StudentEntity? student;
  final String categoryId;
  final String categoryName;
  final String totalAmount;
  final String balance;
  final String status;
  final String dueDate;

  FeeEntity({
    required this.id,
    this.student,
    required this.categoryId,
    required this.categoryName,
    required this.totalAmount,
    required this.balance,
    required this.status,
    required this.dueDate,
  });
}
