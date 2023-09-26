import 'package:barber_app/src/core/ui/constants.dart';
import 'package:barber_app/src/features/auth/login/login_state.dart';
import 'package:barber_app/src/features/auth/login/login_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:validatorless/validatorless.dart';

import '../../../core/ui/helpers/messages.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final LoginVm(:login) = ref.watch(loginVmProvider.notifier);

    ref.listen(loginVmProvider, (_, state) {
      switch (state) {
        case LoginState(status: LoginStateStatus.initial):
          break;
        case LoginState(status: LoginStateStatus.error, :final errorMessage?):
          Messages.showError(context, errorMessage);
          break;
        case LoginState(status: LoginStateStatus.error):
          Messages.showError(context, "Erro ao Realizar o Login");
          break;
        case LoginState(status: LoginStateStatus.admLogin):
          Navigator.of(context).pushNamedAndRemoveUntil("/home/adm", (route) => false);
          break;
        case LoginState(status: LoginStateStatus.employeeLogin):
          Navigator.of(context).pushNamedAndRemoveUntil("/home/employee", (route) => false);

          break;
      }
    });

    return Scaffold(
      backgroundColor: Colors.black,
      body: Form(
        key: _formKey,
        child: DecoratedBox(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(ImageConstants.chairImageBg),
                fit: BoxFit.cover,
                opacity: 0.2),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: CustomScrollView(
                slivers: [
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset("assets/images/imgLogo.png"),
                            const SizedBox(height: 24),
                            TextFormField(
                              controller: _emailController,
                              onTapOutside: (event) =>
                                  FocusScope.of(context).unfocus(),
                              validator: Validatorless.multiple([
                                Validatorless.required(
                                    "O E-mail é obrigatório"),
                                Validatorless.email("Informe um E-mail válido"),
                              ]),
                              decoration: const InputDecoration(
                                label: Text("E-mail"),
                                hintText: "E-mail",
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
                                labelStyle: TextStyle(
                                  color: Colors.black,
                                ),
                                hintStyle: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            const SizedBox(height: 24),
                            TextFormField(
                              controller: _passwordController,
                              obscureText: true,
                              onTapOutside: (event) =>
                                  FocusScope.of(context).unfocus(),
                              validator: Validatorless.multiple(
                                [
                                  Validatorless.required(
                                      "A senha é obrigatória"),
                                  Validatorless.min(6,
                                      "A senha deve conter no mínimo 6 caracteres"),
                                ],
                              ),
                              decoration: const InputDecoration(
                                label: Text("Senha"),
                                hintText: "Senha",
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
                                labelStyle: TextStyle(
                                  color: Colors.black,
                                ),
                                hintStyle: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Esqueceu a Senha?",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: ColorsConstants.brown,
                                ),
                              ),
                            ),
                            const SizedBox(height: 24),
                            ElevatedButton(
                              onPressed: () {
                                switch (_formKey.currentState?.validate()) {
                                  case (null || false):
                                    Messages.showError(
                                        context, "Campos Inválidos");
                                    break;
                                  case true:
                                    login(_emailController.text,
                                        _passwordController.text);
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size.fromHeight(56),
                              ),
                              child: const Text("ACESSAR"),
                            ),
                          ],
                        ),
                        const Align(
                          alignment: Alignment.bottomCenter,
                          child: Text(
                            "Criar Conta",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
