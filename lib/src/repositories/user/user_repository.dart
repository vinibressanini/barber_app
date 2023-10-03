import 'package:barber_app/src/core/exceptions/auth_exception.dart';
import 'package:barber_app/src/core/fp/nil.dart';

import '../../core/exceptions/repository_exception.dart';
import '../../core/fp/either.dart';
import '../../models/user_model.dart';

abstract interface class UserRepository {
  Future<Either<AuthException, String>> login(String email, String password);
  Future<Either<RepositoryException, UserModel>> me();
  Future<Either<RepositoryException, Nil>> registerAdmin(
      ({String name, String email, String password}) userData);
}
