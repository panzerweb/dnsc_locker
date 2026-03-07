import 'package:dnsc_locker/feature/locker_subscription/domain/repository/locker_subscription_request_repository.dart';

class RequestLockerUseCase {
  final LockerSubscriptionRequestRepository requestRepository;

  RequestLockerUseCase(this.requestRepository);

  Future<void> call(int lockerId, String academicYear, String semester) async {
    await requestRepository.requestLocker(lockerId, academicYear, semester);
  }
}
