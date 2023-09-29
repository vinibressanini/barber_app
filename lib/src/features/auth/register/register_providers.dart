import 'package:barber_app/src/core/providers/application_providers.dart';
import 'package:barber_app/src/services/user_register/user_adm_register_service.dart';
import 'package:barber_app/src/services/user_register/user_adm_register_service_impl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'register_providers.g.dart';

@Riverpod(keepAlive: true)
UserAdmRegisterService userAdmService(UserAdmServiceRef ref) {
  return UserAdmRegisterServiceImpl(
    userRepository: ref.read(userRepositoryProvider),
    userLoginService: ref.read(userLoginServiceProvider),
  );
}
