import 'package:dnsc_locker/core/errors/locker_request_error_state.dart';
import 'package:dnsc_locker/feature/locker_subscription/domain/entities/locker_subscription_request_entity.dart';
import 'package:dnsc_locker/feature/locker_subscription/domain/usecases/get_all_submissions_use_case.dart';
import 'package:dnsc_locker/feature/locker_subscription/domain/usecases/request_locker_use_case.dart';
import 'package:dnsc_locker/feature/locker_subscription/presentation/bloc/request_locker_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RequestLockerCubit extends Cubit<RequestLockerState> {
  // Track current page internally
  int _currentPage = 1;
  bool _hasReachedMax = false;
  List<LockerSubscriptionRequestEntity> requests = [];

  final GetAllSubmissionsUseCase getAllSubmissionsUseCase;
  final RequestLockerUseCase requestLockerUseCase;

  RequestLockerCubit({
    required this.requestLockerUseCase,
    required this.getAllSubmissionsUseCase,
  }) : super(RequestLockerInitial());

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
    } catch (e) {
      emit(RequestLockerError("Unexpected error: $e"));
    }
  }

  // Load all requests
  Future<void> getAllRequestsSubmissions() async {
    if (state is RequestLockerLoading || _hasReachedMax) return;

    emit(RequestLockerLoading());

    try {
      final responseData = await getAllSubmissionsUseCase(
        currentPage: _currentPage,
      );

      // Append new data
      requests.addAll(responseData.data);

      _hasReachedMax = _currentPage >= responseData.totalPages;
      _currentPage += 1;

      emit(
        RequestLockersLoaded(
          currentPage: _currentPage - 1, // current page just fetched
          perPage: responseData.perPage,
          totalPages: responseData.totalPages,
          totalItems: responseData.totalItems,
          requests: List.of(requests).toList(), // pass a copy
        ),
      );
    } on LockerRequestErrorState catch (e) {
      emit(RequestLockerError("Error fetching request: ${e.message}"));
    } catch (e) {
      print("Unexpected error: $e"); // log it
      emit(
        RequestLockerError(
          'Unable to connect to server. Please check your internet connection.',
        ),
      );
    }
  }
}
