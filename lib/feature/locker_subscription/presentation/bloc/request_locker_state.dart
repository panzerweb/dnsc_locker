import 'package:dnsc_locker/feature/locker_subscription/domain/entities/locker_subscription_request_entity.dart';

abstract class RequestLockerState {
  const RequestLockerState();
}

class RequestLockerInitial extends RequestLockerState {}

class RequestLockerLoading extends RequestLockerState {}

class RequestLockerSent extends RequestLockerState {}

class RequestLockersLoaded extends RequestLockerState {
  final int currentPage;
  final int perPage;
  final int totalPages;
  final int totalItems;
  final List<LockerSubscriptionRequestEntity> requests;

  const RequestLockersLoaded({
    required this.requests,
    required this.currentPage,
    required this.perPage,
    required this.totalPages,
    required this.totalItems,
  });
}

class RequestLockerError extends RequestLockerState {
  final String message;

  RequestLockerError(this.message);
}
