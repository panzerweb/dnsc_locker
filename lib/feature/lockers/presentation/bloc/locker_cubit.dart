import 'package:dnsc_locker/feature/lockers/domain/usecases/get_lockers_use_case.dart';
import 'package:dnsc_locker/feature/lockers/presentation/bloc/locker_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LockerCubit extends Cubit<LockerState> {
  final GetLockersUseCase getLockersUseCase;

  LockerCubit({required this.getLockersUseCase}) : super(const LockerState());

  Future<void> loadLockers() async {
    if (state.isLoading || state.hasReachedMax) {
      return;
    }
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
    } catch (_) {
      emit(state.copyWith(isLoading: false, errors: true));
    }
  }

  void refresh() {
    emit(const LockerState());
    loadLockers();
  }
}
