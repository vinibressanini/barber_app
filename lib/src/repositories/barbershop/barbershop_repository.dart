import 'package:barber_app/src/core/exceptions/repository_exception.dart';
import 'package:barber_app/src/core/fp/either.dart';
import 'package:barber_app/src/models/barbershop_model.dart';

import '../../core/fp/nil.dart';
import '../../models/user_model.dart';

abstract interface class BarbershopRepository {
  Future<Either<RepositoryException, BarbershopModel>> getMyBarbershop(
      UserModel userModel);
  Future<Either<RepositoryException, Nil>> save(
      ({
        String name,
        String email,
        List<String> openingDays,
        List<int> openingHours
      }) data);
}
