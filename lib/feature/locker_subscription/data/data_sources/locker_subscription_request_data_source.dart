import 'package:dnsc_locker/core/constant/api_response_models.dart';
import 'package:dnsc_locker/feature/locker_subscription/data/models/locker_subscription_request_create_model.dart';
import 'package:dnsc_locker/feature/locker_subscription/data/models/locker_subscription_request_model.dart';
import 'package:dnsc_locker/feature/locker_subscription/data/models/locker_subscription_request_response_model.dart';

abstract class LockerSubscriptionRequestDataSource {
  Future<LockerSubscriptionRequestResponseModel> requestLockerSubscription(
    LockerSubscriptionRequestCreateModel lockerRequest,
  );

  Future<ApiResponseModels<LockerSubscriptionRequestModel>>
  getAllLockerRequestSubmission({required int currentPage});
}
