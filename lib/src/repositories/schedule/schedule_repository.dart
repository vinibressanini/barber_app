import 'package:barber_app/src/core/exceptions/repository_exception.dart';
import 'package:barber_app/src/models/schedule_model.dart';

import '../../core/fp/either.dart';
import '../../core/fp/nil.dart';

abstract interface class ScheduleRepository {
  Future<Either<RepositoryException, Nil>> register(
      ({
        int barbershopId,
        int userId,
        String customerName,
        DateTime date,
        int time,
      }) customerData);

  Future<Either<RepositoryException, List<ScheduleModel>>> findScheduleByDate(
      ({DateTime date, int userId}) filter);
}
