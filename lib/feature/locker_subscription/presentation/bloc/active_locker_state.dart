import 'package:dnsc_locker/core/constant/api_response_entity.dart';
import 'package:dnsc_locker/feature/locker_subscription/domain/entities/active_locker_subscription_entity.dart';

abstract class ActiveLockerState {}

class ActiveLockerInitial extends ActiveLockerState {}

class ActiveLockerLoading extends ActiveLockerState {}

class ActiveLockerLoaded extends ActiveLockerState {
  final ApiResponseEntity<ActiveLockerSubscriptionEntity> response;

  ActiveLockerLoaded(this.response);

  /// optional helper, get the first data
  ActiveLockerSubscriptionEntity? get latestSubscription =>
      response.data.isNotEmpty ? response.data.first : null;
}

class ActiveLockerError extends ActiveLockerState {
  final String message;

  ActiveLockerError(this.message);
}
