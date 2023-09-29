import 'package:barber_app/src/core/exceptions/service_exception.dart';

import '../../core/fp/either.dart';
import '../../core/fp/nil.dart';

abstract interface class UserAdmRegisterService {
  Future<Either<ServiceException, Nil>> execute(
      ({String name, String email, String password}) userData);
}
