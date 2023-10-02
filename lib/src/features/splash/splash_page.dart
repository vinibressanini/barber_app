import 'dart:developer';

import 'package:barber_app/src/core/ui/constants.dart';
import 'package:barber_app/src/features/auth/login/login_page.dart';
import 'package:barber_app/src/features/splash/splash_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/ui/helpers/messages.dart';

class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({super.key});

  @override
  ConsumerState<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage> {
  var logoScale = 10.0;
  var logoOpacity = 0.0;

  double get _logoWidth => 100 * logoScale;
  double get _logoHeight => 120 * logoScale;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      logoOpacity = 1.0;
      logoScale = 1.0;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(splashVmProvider, (_, state) {
      state.whenOrNull(
        error: (error, stackTrace) {
          log("Erro ao validar o login do usuário",
              error: error, stackTrace: stackTrace);
          Messages.showError(context, "Erro ao validar login");
        },
        data: (data) {
          switch (data) {
            case SplashState.loggedADM:
              Navigator.of(context)
                  .pushNamedAndRemoveUntil("/home/adm", (route) => false);
              break;
            case SplashState.loggedEmployee:
              Navigator.of(context)
                  .pushNamedAndRemoveUntil("/home/employee", (route) => false);
              break;
            case _:
              Navigator.of(context)
                  .pushNamedAndRemoveUntil("/auth/login", (route) => false);
              break;
          }
        },
      );
    });

    return Scaffold(
      backgroundColor: Colors.black,
      body: DecoratedBox(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(ImageConstants.chairImageBg),
                fit: BoxFit.cover,
                opacity: 0.2),
          ),
          child: Center(
            child: AnimatedOpacity(
              opacity: logoOpacity,
              duration: const Duration(seconds: 1),
              curve: Curves.easeIn,
              onEnd: () {
                Navigator.of(context).pushAndRemoveUntil(
                    PageRouteBuilder(
                      settings: const RouteSettings(name: "/auth/login"),
                      pageBuilder: (conext, animation, secondaryAnimation) {
                        return const LoginPage();
                      },
                      transitionsBuilder: (_, animation, __, child) {
                        return FadeTransition(
                          opacity: animation,
                          child: child,
                        );
                      },
                    ),
                    (route) => false);
              },
              child: AnimatedContainer(
                  duration: const Duration(seconds: 1),
                  width: _logoWidth,
                  height: _logoHeight,
                  curve: Curves.linearToEaseOut,
                  child: Image.asset(
                    ImageConstants.dwBarberLogo,
                    fit: BoxFit.cover,
                  )),
            ),
          )),
    );
  }
}
