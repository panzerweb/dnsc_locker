import 'package:dio/dio.dart';
import 'package:dnsc_locker/core/constant/api_path.dart';
import 'package:dnsc_locker/core/constant/api_response_models.dart';
import 'package:dnsc_locker/feature/locker_subscription/data/data_sources/active_subscription_data_source.dart';
import 'package:dnsc_locker/feature/locker_subscription/data/models/active_locker_subscription_model.dart';

class ActiveSubscriptionDataSourceImpl implements ActiveSubscriptionDataSource {
  final Dio dio;

  ActiveSubscriptionDataSourceImpl(this.dio);

  @override
  Future<ApiResponseModels<ActiveLockerSubscriptionModel>>
  getActiveLockerSubscriptions() async {
    try {
      final response = await dio.get(ApiPath.activeLocker);

      // print("Fetched data: ${response.data['data']}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.data['data'];

        return ApiResponseModels.fromJson(
          data,
          (json) => ActiveLockerSubscriptionModel.fromJson(json),
        );
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.unknown) {
        throw ("Connectivity Error: check your internet connection. $e");
      }

      throw ("Error fetching active subscription: $e");
    }
    throw Exception("Fetching data error");
  }
}
