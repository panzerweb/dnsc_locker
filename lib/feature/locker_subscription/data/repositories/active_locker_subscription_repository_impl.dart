import 'package:dnsc_locker/core/constant/api_response_entity.dart';
import 'package:dnsc_locker/feature/locker_subscription/data/data_sources/active_subscription_data_source.dart';
import 'package:dnsc_locker/feature/locker_subscription/domain/entities/active_locker_subscription_entity.dart';
import 'package:dnsc_locker/feature/locker_subscription/domain/repository/active_locker_subscription_repository.dart';

class ActiveLockerSubscriptionRepositoryImpl
    implements ActiveLockerSubscriptionRepository {
  final ActiveSubscriptionDataSource remoteDataSource;

  ActiveLockerSubscriptionRepositoryImpl(this.remoteDataSource);

  @override
  Future<ApiResponseEntity<ActiveLockerSubscriptionEntity>>
  getActiveLockerSubscriptions() async {
    final response = await remoteDataSource.getActiveLockerSubscriptions();

    return response.toEntity<ActiveLockerSubscriptionEntity>(
      (model) => model.toEntity(),
    );
  }
}
