import 'package:barber_app/src/core/constants/local_storage_keys.dart';
import 'package:barber_app/src/core/exceptions/auth_exception.dart';
import 'package:barber_app/src/core/exceptions/service_exception.dart';
import 'package:barber_app/src/core/fp/either.dart';
import 'package:barber_app/src/core/fp/nil.dart';
import 'package:barber_app/src/repositories/user/user_repository.dart';
import 'package:barber_app/src/services/user_login/user_login_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserLoginServiceImpl implements UserLoginService {
  final UserRepository repo;

  UserLoginServiceImpl({required this.repo});

  @override
  Future<Either<ServiceException, Nil>> execute(
      String email, String password) async {
    final loginResult = await repo.login(email, password);

    switch (loginResult) {
      case Success(value: final accessToken):
        final sp = await SharedPreferences.getInstance();

        sp.setString(LocalStorageKeys.accessToken, accessToken);

        return Success(nil);

      case Failure(:final exception):
        return switch (exception) {
          AuthError() =>
            Failure(ServiceException(message: "Erro ao realizar o login")),
          UnauthorizedAuthException() =>
            Failure(ServiceException(message: "Login ou/e senha incorretos")),
        };
    }
  }
}
