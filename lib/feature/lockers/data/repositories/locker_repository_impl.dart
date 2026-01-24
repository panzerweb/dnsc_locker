import 'package:dnsc_locker/feature/lockers/data/data_sources/lockers_remote_data_source.dart';
import 'package:dnsc_locker/feature/lockers/domain/entities/locker_entity.dart';
import 'package:dnsc_locker/feature/lockers/domain/repository/locker_repository.dart';

class LockerRepositoryImpl implements LockerRepository {
  final LockersRemoteDataSource remote;

  LockerRepositoryImpl(this.remote);

  @override
  Future<List<LockerEntity>> getLockers() async {
    final lockersModel = await remote.getLockers();
    final lockerEntity = lockersModel
        .map((locker) => locker.toEntity())
        .toList();

    return lockerEntity;
  }
}
