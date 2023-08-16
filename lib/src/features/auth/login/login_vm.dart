import 'package:asyncstate/asyncstate.dart';
import 'package:barber_app/src/core/exceptions/service_exception.dart';
import 'package:barber_app/src/core/providers/application_providers.dart';
import 'package:barber_app/src/features/auth/login/login_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/fp/either.dart';

part 'login_vm.g.dart';

@riverpod
class LoginVm extends _$LoginVm {
  @override
  LoginState build() => LoginState.initial();

  Future<void> login(String email, String password) async {
    final asyncLoader = AsyncLoaderHandler()..start();

    final userService = ref.watch(userLoginServiceProvider);

    var response = await userService.execute(email, password);

    switch (response) {
      case Success():
        // buscar dados do usuário logado
        // fazer analise de qual o tipo do login
        break;
      case Failure(exception: ServiceException(:final message)):
        state = state.copyWith(
          status: LoginStateStatus.error,
          errorMessage: () => message,
        );
    }

    asyncLoader.close();
  }
}
