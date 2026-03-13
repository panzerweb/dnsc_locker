import 'package:dnsc_locker/feature/auth/data/models/student_model.dart';
import 'package:dnsc_locker/feature/locker_subscription/domain/entities/fee_entity.dart';

class FeeModel {
  final int id;
  final StudentModel? student;
  final String categoryId;
  final String categoryName;
  final String totalAmount;
  final String balance;
  final String status;
  final String dueDate;

  FeeModel({
    required this.id,
    this.student,
    required this.categoryId,
    required this.categoryName,
    required this.totalAmount,
    required this.balance,
    required this.status,
    required this.dueDate,
  });

  factory FeeModel.fromJson(Map<String, dynamic> json) {
    return FeeModel(
      id: json['id'],
      student: json['student'] != null
          ? StudentModel.fromJson(json['student'])
          : null,
      categoryId: json['category_id'],
      categoryName: json['category_name'],
      totalAmount: json['total_amount'],
      balance: json['balance'],
      status: json['status'],
      dueDate: json['due_date'],
    );
  }

  FeeEntity toEntity() {
    return FeeEntity(
      id: id,
      student: student?.toEntity(),
      categoryId: categoryId,
      categoryName: categoryName,
      totalAmount: totalAmount,
      balance: balance,
      status: status,
      dueDate: dueDate,
    );
  }
}
