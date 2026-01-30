import 'package:dnsc_locker/core/constant/api_response_entity.dart';
import 'package:dnsc_locker/feature/lockers/domain/entities/locker_entity.dart';
import 'package:dnsc_locker/feature/lockers/domain/repository/locker_repository.dart';

class GetLockersUseCase {
  final LockerRepository lockerRepo;

  GetLockersUseCase(this.lockerRepo);

  Future<ApiResponseEntity<LockerEntity>> call({required int page}) async {
    final lockersFetched = await lockerRepo.getLockers(page);

    return lockersFetched;
  }
}
