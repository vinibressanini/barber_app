import 'package:barber_app/src/core/constants/local_storage_keys.dart';
import 'package:barber_app/src/core/providers/application_providers.dart';
import 'package:barber_app/src/models/user_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'splash_vm.g.dart';

@riverpod
class SplashVm extends _$SplashVm {
  @override
  Future<SplashState> build() async {
    try {
      final sp = await SharedPreferences.getInstance();

      if (sp.containsKey(LocalStorageKeys.accessToken)) {
        ref.invalidate(getMeProvider);
        ref.invalidate(getMyBarbershopProvider);

        var user = await ref.watch(getMeProvider.future);

        switch (user) {
          case UserModelADM():
            return SplashState.loggedADM;
          case UserModelEmployee():
            return SplashState.loggedEmployee;
        }
      }

      return SplashState.login;
    } catch (e) {
      return SplashState.login;
    }
  }
}

enum SplashState { initial, login, loggedADM, loggedEmployee, error }
