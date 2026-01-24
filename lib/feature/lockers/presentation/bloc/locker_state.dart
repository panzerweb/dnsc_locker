import 'package:dnsc_locker/feature/lockers/domain/entities/locker_entity.dart';

abstract class LockerState {
  const LockerState();
}

class LockerInitial extends LockerState {}

class LockerLoading extends LockerState {}

class LockerLoaded extends LockerState {
  final List<LockerEntity> lockers;

  LockerLoaded(this.lockers);
}

class LockerError extends LockerState {
  final String error;

  LockerError(this.error);
}
