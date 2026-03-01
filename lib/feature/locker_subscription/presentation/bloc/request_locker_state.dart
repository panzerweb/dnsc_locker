abstract class RequestLockerState {
  const RequestLockerState();
}

class RequestLockerInitial extends RequestLockerState {}

class RequestLockerLoading extends RequestLockerState {}

class RequestLockerSent extends RequestLockerState {}

class RequestLockerError extends RequestLockerState {
  final String message;

  RequestLockerError(this.message);
}
