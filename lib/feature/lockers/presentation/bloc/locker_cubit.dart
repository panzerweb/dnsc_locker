import 'package:dnsc_locker/feature/lockers/domain/usecases/get_lockers_use_case.dart';
import 'package:dnsc_locker/feature/lockers/presentation/bloc/locker_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LockerCubit extends Cubit<LockerState> {
  final GetLockersUseCase getLockersUseCase;

  LockerCubit({required this.getLockersUseCase}) : super(LockerInitial());

  Future<void> loadLockers() async {
    emit(LockerLoading());

    try {
      final lockers = await getLockersUseCase();

      if (lockers.isEmpty) {
        emit(LockerError('There are no fetched lockers in the cubit'));
      } else {
        emit(LockerLoaded(lockers));
      }
    } catch (e) {
      print(e);
      emit(LockerError('Error fetching lockers: $e'));
    }
  }
}
