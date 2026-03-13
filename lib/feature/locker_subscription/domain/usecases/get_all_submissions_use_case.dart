import 'package:dnsc_locker/core/constant/api_response_entity.dart';
import 'package:dnsc_locker/feature/locker_subscription/domain/entities/locker_subscription_request_entity.dart';
import 'package:dnsc_locker/feature/locker_subscription/domain/repository/locker_subscription_request_repository.dart';

class GetAllSubmissionsUseCase {
  final LockerSubscriptionRequestRepository lockerSubscriptionRequestRepository;

  GetAllSubmissionsUseCase(this.lockerSubscriptionRequestRepository);

  Future<ApiResponseEntity<LockerSubscriptionRequestEntity>> call({
    required int currentPage,
  }) async {
    final response = await lockerSubscriptionRequestRepository
        .getAllSubmissions(currentPage: currentPage);

    return response;
  }
}
