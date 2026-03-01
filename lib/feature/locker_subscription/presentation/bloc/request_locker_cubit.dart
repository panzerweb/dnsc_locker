import 'package:dnsc_locker/core/errors/locker_request_error_state.dart';
import 'package:dnsc_locker/feature/locker_subscription/domain/usecases/request_locker_use_case.dart';
import 'package:dnsc_locker/feature/locker_subscription/presentation/bloc/request_locker_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RequestLockerCubit extends Cubit<RequestLockerState> {
  final RequestLockerUseCase requestLockerUseCase;

  RequestLockerCubit({required this.requestLockerUseCase})
    : super(RequestLockerInitial());

  // Submit a request
  Future<void> submitLockerRequest(
    int lockerId,
    String academicYear,
    String semester,
  ) async {
    emit(RequestLockerLoading());
    try {
      await requestLockerUseCase(lockerId, academicYear, semester);

      emit(RequestLockerSent());
    } on LockerRequestErrorState catch (e) {
      emit(RequestLockerError("Error submitting request: ${e.message}"));
    } catch (_) {
      emit(RequestLockerError('Unexpected error. Please try again.'));
    }
  }
}
