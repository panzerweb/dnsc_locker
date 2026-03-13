import 'package:dnsc_locker/feature/locker_subscription/domain/usecases/active_subscriptions_use_case.dart';
import 'package:dnsc_locker/feature/locker_subscription/presentation/bloc/active_locker_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ActiveLockerCubit extends Cubit<ActiveLockerState> {
  final ActiveSubscriptionsUseCase activeSubscriptionsUseCase;

  ActiveLockerCubit({required this.activeSubscriptionsUseCase})
    : super(ActiveLockerInitial());

  Future<void> loadActiveLockerSubscriptions() async {
    emit(ActiveLockerLoading());

    try {
      final response = await activeSubscriptionsUseCase
          .getActiveSubscriptions();

      emit(ActiveLockerLoaded(response));
    } catch (e) {
      emit(ActiveLockerError(e.toString()));
    }
  }
}
