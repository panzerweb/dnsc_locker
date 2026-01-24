import 'package:dnsc_locker/core/constant/api_response_entity.dart';

class ApiResponseModels<T> {
  final int currentPage;
  final int perPage;
  final int totalPages;
  final int totalItems;
  final List<T> data;

  ApiResponseModels({
    required this.currentPage,
    required this.perPage,
    required this.totalPages,
    required this.totalItems,
    required this.data,
  });

  factory ApiResponseModels.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) fromJsonT,
  ) {
    final list = (json['data'] as List<dynamic>? ?? []);
    return ApiResponseModels(
      currentPage: json['current_page'] as int,
      perPage: json['per_page'] as int,
      totalPages: json['total_pages'] as int,
      totalItems: json['total_items'] as int,
      data: list.map((e) => fromJsonT(e as Map<String, dynamic>)).toList(),
    );
  }

  ApiResponseEntity toEntity() {
    return ApiResponseEntity(
      currentPage: currentPage,
      perPage: perPage,
      totalPages: totalPages,
      totalItems: totalItems,
      data: data,
    );
  }
}
