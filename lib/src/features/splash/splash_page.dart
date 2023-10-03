import 'dart:async';
import 'dart:developer';

import 'package:barber_app/src/core/ui/constants.dart';
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

  var endAnimation = false;
  Timer? redirectTimer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      logoOpacity = 1.0;
      logoScale = 1.0;
      setState(() {});
    });
  }

  void redirect(String routeName) {
    if (!endAnimation) {
      redirectTimer?.cancel();
      redirectTimer = Timer(const Duration(milliseconds: 300), () {
        redirect(routeName);
      });
    } else {
      redirectTimer?.cancel();
      Navigator.of(context).pushNamedAndRemoveUntil(
        routeName,
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(splashVmProvider, (_, state) {
      state.whenOrNull(
        error: (error, stackTrace) {
          log("Erro ao validar o login do usuário",
              error: error, stackTrace: stackTrace);
          Messages.showError(context, "Erro ao validar login");
          redirect("/auth/login");
        },
        data: (data) {
          switch (data) {
            case SplashState.loggedADM:
              redirect("/home/adm");
              break;
            case SplashState.loggedEmployee:
              redirect("/home/employee");
              break;
            case _:
              redirect("/auth/login");
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
                setState(() {
                  endAnimation = !endAnimation;
                });
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
