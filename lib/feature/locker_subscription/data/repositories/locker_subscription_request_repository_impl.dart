import 'package:dnsc_locker/core/constant/api_response_entity.dart';
import 'package:dnsc_locker/core/errors/locker_request_error_state.dart';
import 'package:dnsc_locker/feature/locker_subscription/data/data_sources/locker_subscription_request_data_source.dart';
import 'package:dnsc_locker/feature/locker_subscription/data/models/locker_subscription_request_create_model.dart';
import 'package:dnsc_locker/feature/locker_subscription/domain/entities/locker_subscription_request_entity.dart';
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
    final requestModel = LockerSubscriptionRequestCreateModel(
      lockerId: lockerId,
      academicYear: academicYear,
      semester: semester,
    );

    final response = await dataSource.requestLockerSubscription(requestModel);

    return response.toEntity();
  }

  @override
  Future<ApiResponseEntity<LockerSubscriptionRequestEntity>> getAllSubmissions({
    required int currentPage,
  }) async {
    final submissionsModel = await dataSource.getAllLockerRequestSubmission(
      currentPage: currentPage,
    );
    final submissionsEntity = submissionsModel.toEntity(
      (model) => model.toEntity(),
    );
    return submissionsEntity;
  }
}
