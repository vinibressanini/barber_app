import 'package:barber_app/src/core/exceptions/repository_exception.dart';

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
}
