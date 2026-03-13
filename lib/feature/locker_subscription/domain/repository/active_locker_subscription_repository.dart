import 'package:dnsc_locker/core/constant/api_response_entity.dart';
import 'package:dnsc_locker/feature/locker_subscription/domain/entities/active_locker_subscription_entity.dart';

abstract class ActiveLockerSubscriptionRepository {
  Future<ApiResponseEntity<ActiveLockerSubscriptionEntity>>
  getActiveLockerSubscriptions();
}
