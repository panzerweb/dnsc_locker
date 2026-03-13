import 'package:dio/dio.dart';
import 'package:dnsc_locker/core/constant/api_path.dart';
import 'package:dnsc_locker/core/constant/api_response_models.dart';
import 'package:dnsc_locker/core/errors/locker_request_error_state.dart';
import 'package:dnsc_locker/feature/locker_subscription/data/data_sources/locker_subscription_request_data_source.dart';
import 'package:dnsc_locker/feature/locker_subscription/data/models/locker_subscription_request_create_model.dart';
import 'package:dnsc_locker/feature/locker_subscription/data/models/locker_subscription_request_model.dart';
import 'package:dnsc_locker/feature/locker_subscription/data/models/locker_subscription_request_response_model.dart';
import 'package:flutter/material.dart';

class LockerSubscriptionRequestDataSourceImpl
    implements LockerSubscriptionRequestDataSource {
  final Dio dio;

  LockerSubscriptionRequestDataSourceImpl(this.dio);

  @override
  Future<LockerSubscriptionRequestResponseModel> requestLockerSubscription(
    LockerSubscriptionRequestCreateModel lockerRequest,
  ) async {
    try {
      final response = await dio.post(
        ApiPath.requestLocker,
        data: lockerRequest.toJson(),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return LockerSubscriptionRequestResponseModel.fromJson(response.data);
      }

      // Fallback for non-200/201 responses
      throw RequestLockerInvalidResponse();
    } on DioException catch (e) {
      // Network timeout
      if (e.type == DioExceptionType.connectionTimeout) {
        throw LockerRequestNetworkTimeout();
      }

      // HTTP error with response data
      final responseData = e.response?.data;

      if (responseData != null) {
        String message = "Something went wrong";

        // Prefer validation errors if present
        if (responseData['errors'] != null) {
          final errors = responseData['errors'] as Map<String, dynamic>;

          // Combine all error messages into a single string
          final errorMessages = errors.values
              .expand((value) => (value as List).cast<String>())
              .toList();

          if (errorMessages.isNotEmpty) {
            message = errorMessages.join(", ");
          }
        } else if (responseData['message'] != null) {
          message = responseData['message'];
        }
        throw LockerRequestErrorState(message);
      }

      // Fallback generic error
      throw LockerRequestErrorState("Error: ${e.message}");
    } catch (e) {
      throw LockerRequestErrorState("Unexpected error occurred: $e");
    }
  }

  @override
  Future<ApiResponseModels<LockerSubscriptionRequestModel>>
  getAllLockerRequestSubmission({required int currentPage}) async {
    try {
      final response = await dio.get(
        ApiPath.getSubmissions,
        queryParameters: {'current_page': currentPage},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final paginatedData = ApiResponseModels.fromJson(
          response.data['data'],
          (json) => LockerSubscriptionRequestModel.fromJson(json),
        );

        return paginatedData;
      }
    } on DioException catch (e, stack) {
      print('Fetching lockers failed: $e');
      debugPrintStack(stackTrace: stack);
    }

    throw Exception("Something is wrong fetching requests submissions");
  }
}
