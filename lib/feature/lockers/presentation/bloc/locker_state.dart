import 'package:dnsc_locker/feature/lockers/domain/entities/locker_entity.dart';

class LockerState {
  final List<LockerEntity> lockers;
  final bool isLoading;
  final bool hasReachedMax;
  final int currentPage;
  final bool? error;
  final bool isFiltered;

  const LockerState({
    this.lockers = const [],
    this.isLoading = false,
    this.hasReachedMax = false,
    this.currentPage = 1,
    this.error,
    this.isFiltered = false,
  });

  LockerState copyWith({
    List<LockerEntity>? lockers,
    bool? isLoading,
    bool? hasReachedMax,
    int? currentPage,
    bool? errors,
    bool? isFiltered,
  }) {
    return LockerState(
      lockers: lockers ?? this.lockers,
      isLoading: isLoading ?? this.isLoading,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      currentPage: currentPage ?? this.currentPage,
      error: errors,
      isFiltered: isFiltered ?? this.isFiltered,
    );
  }
}
