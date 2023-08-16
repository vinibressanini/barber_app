import 'package:barber_app/src/core/ui/constants.dart';
import 'package:barber_app/src/features/auth/login/login_page.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
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
