class LockerRequestErrorState implements Exception {
  final String message;

  LockerRequestErrorState(this.message);
}

class RequestLockerInvalidResponse extends LockerRequestErrorState {
  RequestLockerInvalidResponse()
    : super("Invalid Server Response: fields may not be filled correctly");
}

class LockerRequestNetworkTimeout extends LockerRequestErrorState {
  LockerRequestNetworkTimeout()
    : super("Connection timeout: check internet connectivity.");
}
