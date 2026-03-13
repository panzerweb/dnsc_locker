import 'package:dnsc_locker/core/constant/api_response_entity.dart';
import 'package:dnsc_locker/feature/locker_subscription/domain/entities/active_locker_subscription_entity.dart';
import 'package:dnsc_locker/feature/locker_subscription/domain/repository/active_locker_subscription_repository.dart';

class ActiveSubscriptionsUseCase {
  final ActiveLockerSubscriptionRepository activeLockerSubscriptionRepository;

  ActiveSubscriptionsUseCase(this.activeLockerSubscriptionRepository);

  Future<ApiResponseEntity<ActiveLockerSubscriptionEntity>>
  getActiveSubscriptions() async {
    final activeLockersFetched = await activeLockerSubscriptionRepository
        .getActiveLockerSubscriptions();

    return activeLockersFetched;
  }
}
