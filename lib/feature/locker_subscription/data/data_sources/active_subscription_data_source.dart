import 'package:dnsc_locker/core/constant/api_response_models.dart';
import 'package:dnsc_locker/feature/locker_subscription/data/models/active_locker_subscription_model.dart';

abstract class ActiveSubscriptionDataSource {
  Future<ApiResponseModels<ActiveLockerSubscriptionModel>>
  getActiveLockerSubscriptions();
}
