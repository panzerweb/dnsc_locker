import 'package:dnsc_locker/core/constant/api_response_entity.dart';
import 'package:dnsc_locker/feature/locker_subscription/domain/entities/locker_subscription_request_entity.dart';
import 'package:dnsc_locker/feature/locker_subscription/domain/entities/locker_subscription_request_response_entity.dart';

abstract class LockerSubscriptionRequestRepository {
  Future<LockerSubscriptionRequestResponseEntity> requestLocker(
    int lockerId,
    String academicYear,
    String semester,
  );

  Future<ApiResponseEntity<LockerSubscriptionRequestEntity>> getAllSubmissions({
    required int currentPage,
  });
}
