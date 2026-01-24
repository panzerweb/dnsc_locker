import 'package:dnsc_locker/feature/lockers/domain/entities/locker_entity.dart';
import 'package:dnsc_locker/feature/lockers/domain/repository/locker_repository.dart';

class GetLockersUseCase {
  final LockerRepository lockerRepo;

  GetLockersUseCase(this.lockerRepo);

  Future<List<LockerEntity>> call() async {
    final lockersFetched = await lockerRepo.getLockers();

    return lockersFetched;
  }
}
