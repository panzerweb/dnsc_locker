import 'package:dnsc_locker/feature/lockers/domain/entities/locker_entity.dart';

abstract class LockerRepository {
  Future<List<LockerEntity>> getLockers();
}
