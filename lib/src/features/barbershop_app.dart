import 'package:asyncstate/widget/async_state_builder.dart';
import 'package:barber_app/src/core/ui/barbershop_nav_global_key.dart';
import 'package:barber_app/src/core/ui/barbershop_theme.dart';
import 'package:barber_app/src/features/splash/splash_page.dart';
import 'package:flutter/material.dart';

import 'auth/login/login_page.dart';

class BarbershopApp extends StatelessWidget {
  const BarbershopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AsyncStateBuilder(
      builder: (asyncNavigatorObserver) {
        return MaterialApp(
          initialRoute: "/",
          theme: BarbershopTheme.themeDate,
          navigatorObservers: [asyncNavigatorObserver],
          navigatorKey: BarbershopNavGlobalKey.instance.key,
          routes: {
            "/": (_) => const SplashPage(),
            "/auth/login": (_) => const LoginPage(),
            "/home/adm": (_) => const Text("ADM"),
            "/home/employee": (_) => const Text("EMPLOYEE"),
          },
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
