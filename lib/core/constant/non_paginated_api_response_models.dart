import 'package:dnsc_locker/core/constant/non_paginated_api_response_entity.dart';

class NonPaginatedApiResponseModels<T> {
  List<T> data;

  NonPaginatedApiResponseModels({required this.data});

  factory NonPaginatedApiResponseModels.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) fromJsonT,
  ) {
    final list = (json['data'] as List<dynamic>? ?? []);

    return NonPaginatedApiResponseModels(
      data: list.map((value) => fromJsonT(value)).toList(),
    );
  }

  NonPaginatedApiResponseEntity<E> toEntity<E>(
    E Function(T model) mapToEntity,
  ) {
    return NonPaginatedApiResponseEntity<E>(
      data: data.map(mapToEntity).toList(),
    );
  }
}
