import 'package:dnsc_locker/feature/locker_subscription/domain/entities/locker_subscription_request_response_entity.dart';
import 'package:dnsc_locker/feature/locker_subscription/domain/repository/locker_subscription_request_repository.dart';

class RequestLockerUseCase {
  final LockerSubscriptionRequestRepository requestRepository;

  RequestLockerUseCase(this.requestRepository);

  Future<LockerSubscriptionRequestResponseEntity> call(
    int lockerId,
    String academicYear,
    String semester,
  ) async {
    final response = await requestRepository.requestLocker(
      lockerId,
      academicYear,
      semester,
    );

    return response;
  }
}
