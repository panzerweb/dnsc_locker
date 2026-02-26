import 'package:dnsc_locker/feature/locker_subscription/data/data_sources/locker_subscription_request_data_source.dart';
import 'package:dnsc_locker/feature/locker_subscription/data/models/locker_subscription_request_create_model.dart';
import 'package:dnsc_locker/feature/locker_subscription/domain/entities/locker_subscription_request_response_entity.dart';
import 'package:dnsc_locker/feature/locker_subscription/domain/repository/locker_subscription_request_repository.dart';

class LockerSubscriptionRequestRepositoryImpl
    implements LockerSubscriptionRequestRepository {
  final LockerSubscriptionRequestDataSource dataSource;

  LockerSubscriptionRequestRepositoryImpl(this.dataSource);

  @override
  Future<LockerSubscriptionRequestResponseEntity> requestLocker(
    int lockerId,
    String academicYear,
    String semester,
  ) async {
    try {
      final requestModel = LockerSubscriptionRequestCreateModel(
        lockerId: lockerId,
        academicYear: academicYear,
        semester: semester,
      );

      final response = await dataSource.requestLockerSubscription(requestModel);

      return response.toEntity();
    } catch (e) {
      throw Exception("Repository Error $e");
    }
  }
}
