import 'package:dnsc_locker/core/constant/api_response_entity.dart';
import 'package:dnsc_locker/feature/lockers/data/data_sources/lockers_remote_data_source.dart';
import 'package:dnsc_locker/feature/lockers/domain/entities/locker_entity.dart';
import 'package:dnsc_locker/feature/lockers/domain/repository/locker_repository.dart';

class LockerRepositoryImpl implements LockerRepository {
  final LockersRemoteDataSource remote;

  LockerRepositoryImpl(this.remote);

  @override
  Future<ApiResponseEntity<LockerEntity>> getLockers(int page) async {
    final lockersModel = await remote.getLockers(page: page);
    final lockerEntity = lockersModel.toEntity<LockerEntity>(
      (model) => model.toEntity(),
    );

    return lockerEntity;
  }
}
