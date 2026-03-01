import 'package:dio/dio.dart';
import 'package:dnsc_locker/core/constant/api_path.dart';
import 'package:dnsc_locker/core/errors/locker_request_error_state.dart';
import 'package:dnsc_locker/feature/locker_subscription/data/data_sources/locker_subscription_request_data_source.dart';
import 'package:dnsc_locker/feature/locker_subscription/data/models/locker_subscription_request_create_model.dart';
import 'package:dnsc_locker/feature/locker_subscription/data/models/locker_subscription_request_response_model.dart';

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

      throw RequestLockerInvalidResponse();
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        throw LockerRequestNetworkTimeout;
      }

      throw LockerRequestErrorState(
        e.response?.data['message'] ?? "Something went wrong",
      );
    }
  }
}
