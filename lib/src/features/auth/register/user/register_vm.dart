import 'package:asyncstate/asyncstate.dart';
import 'package:barber_app/src/core/providers/application_providers.dart';
import 'package:barber_app/src/features/auth/register/user/register_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/fp/either.dart';

part 'register_vm.g.dart';

@riverpod
class RegisterVm extends _$RegisterVm {
  @override
  UserRegisterStateStatus build() => UserRegisterStateStatus.initial;

  Future<void> register({
    required String name,
    required String email,
    required String password,
  }) async {
    var admRegisterService = ref.watch(userAdmServiceProvider);

    var userDto = (
      name: name,
      email: email,
      password: password,
    );

    var registerResult =
        await admRegisterService.execute(userDto).asyncLoader();

    switch (registerResult) {
      case Success():
        ref.invalidate(getMeProvider);
        state = UserRegisterStateStatus.success;
      case Failure():
        state = UserRegisterStateStatus.failure;
    }
  }
}

enum UserRegisterStateStatus {
  initial,
  success,
  failure,
}
