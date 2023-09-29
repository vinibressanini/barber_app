import 'package:barber_app/src/core/exceptions/service_exception.dart';
import 'package:barber_app/src/core/fp/either.dart';
import 'package:barber_app/src/core/fp/nil.dart';
import 'package:barber_app/src/repositories/user/user_repository.dart';
import 'package:barber_app/src/services/user_login/user_login_service.dart';
import 'package:barber_app/src/services/user_register/user_adm_register_service.dart';

class UserAdmRegisterServiceImpl implements UserAdmRegisterService {
  final UserRepository userRepository;
  final UserLoginService userLoginService;

  UserAdmRegisterServiceImpl(
      {required this.userRepository, required this.userLoginService});

  @override
  Future<Either<ServiceException, Nil>> execute(
      ({String email, String name, String password}) userData) async {
    final registerResult = await userRepository.registerAdmin(userData);

    switch (registerResult) {
      case Success():
        return await userLoginService.execute(
            userData.email, userData.password);
      case Failure(:final exception):
        return Failure(ServiceException(exception.message));
    }
  }
}
