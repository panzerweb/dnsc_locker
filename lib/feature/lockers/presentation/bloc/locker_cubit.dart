import 'package:dnsc_locker/feature/lockers/domain/usecases/filter_lockers_use_case.dart';
import 'package:dnsc_locker/feature/lockers/domain/usecases/get_lockers_use_case.dart';
import 'package:dnsc_locker/feature/lockers/presentation/bloc/locker_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LockerCubit extends Cubit<LockerState> {
  final GetLockersUseCase getLockersUseCase;
  final FilterLockersUseCase filterLockersUseCase;

  LockerCubit({
    required this.getLockersUseCase,
    required this.filterLockersUseCase,
  }) : super(const LockerState());

  Future<void> loadLockers() async {
    if (state.isLoading || state.hasReachedMax) {
      return;
    }
    print("LOAD LOCKERS CALLED");

    emit(state.copyWith(isLoading: true));

    try {
      final response = await getLockersUseCase(page: state.currentPage);

      final isLastPage = response.currentPage >= response.totalPages;

      emit(
        state.copyWith(
          lockers: List.of(state.lockers)..addAll(response.data),
          currentPage: state.currentPage + 1,
          hasReachedMax: isLastPage,
          isLoading: false,
          errors: null,
        ),
      );
    } catch (e, stack) {
      print("FETCHING LOCKERS ERROR: $e");
      print(stack);
      emit(state.copyWith(isLoading: false, errors: true));
    }
  }

  Future<void> loadAvailableLockers({
    required String academicYear,
    int? building,
    required String semester,
  }) async {
    print("AVAILABLE LOCKERS CALLED");

    emit(state.copyWith(errors: null, isLoading: true));

    try {
      final response = await filterLockersUseCase(
        academicYear: academicYear,
        building: building,
        semester: semester,
      );
      if (response.data.isNotEmpty) {
        emit(
          state.copyWith(
            lockers: response.data,
            isFiltered: true,
            currentPage: 1,
            hasReachedMax: true,
            isLoading: false,
            errors: null,
          ),
        );
      } else {
        emit(state.copyWith(lockers: [], isLoading: false, errors: null));
      }
    } catch (e, stack) {
      print("FILTER ERROR: $e");
      print(stack);
      emit(state.copyWith(isLoading: false, errors: true));
    }
  }

  void resetAndLoad() {
    emit(const LockerState());
    loadLockers();
  }

  void refresh() {
    emit(const LockerState());
    loadLockers();
  }
}
