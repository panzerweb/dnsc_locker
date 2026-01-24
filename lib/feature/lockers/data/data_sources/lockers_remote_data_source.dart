import 'package:dnsc_locker/feature/lockers/data/models/locker_models.dart';

abstract class LockersRemoteDataSource {
  Future<List<LockerModels>> getLockers();
}
