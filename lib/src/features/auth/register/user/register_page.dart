import 'package:barber_app/src/features/auth/register/user/register_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:validatorless/validatorless.dart';

import '../../../../core/ui/helpers/messages.dart';

class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({super.key});

  @override
  ConsumerState<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage> {
  final _nameEC = TextEditingController();
  final _emailEC = TextEditingController();
  final _passwordEC = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    ref.listen(registerVmProvider, (_, state) {
      switch (state) {
        case UserRegisterStateStatus.initial:
          break;
        case UserRegisterStateStatus.success:
          Messages.showSuccess(context, "Conta criada com sucesso!");
          Navigator.of(context).pushNamed('auth/register/barbershop');
          break;
        case UserRegisterStateStatus.failure:
          Messages.showError(context, "Erro ao criar a conta. Tente novamente");
          break;
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Criar Conta'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 20),
                TextFormField(
                  onTapOutside: (event) => FocusScope.of(context).unfocus(),
                  controller: _nameEC,
                  decoration: const InputDecoration(
                    label: Text("Nome"),
                  ),
                  validator: Validatorless.required("Este campo é obrigatório"),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _emailEC,
                  onTapOutside: (event) => FocusScope.of(context).unfocus(),
                  decoration: const InputDecoration(
                    label: Text("E-mail"),
                  ),
                  validator: Validatorless.multiple([
                    Validatorless.required("o email é obrigatório"),
                    Validatorless.email("Informe um emial válido"),
                  ]),
                ),
                const SizedBox(height: 20),
                TextFormField(
                    onTapOutside: (event) => FocusScope.of(context).unfocus(),
                    controller: _passwordEC,
                    decoration: const InputDecoration(
                      label: Text("Senha"),
                    ),
                    validator: Validatorless.multiple([
                      Validatorless.required("A senha é obrigatória"),
                      Validatorless.min(
                          6, "A senha deve conter no minímo 6 caracteres")
                    ])),
                const SizedBox(height: 20),
                TextFormField(
                  onTapOutside: (event) => FocusScope.of(context).unfocus(),
                  decoration: const InputDecoration(
                    label: Text("Confirme a Senha"),
                  ),
                  validator: Validatorless.compare(
                      _passwordEC, "As senhas não coincidem"),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    switch (_formKey.currentState?.validate()) {
                      case (null || false):
                        Messages.showError(context, "Campos Inválidos");
                        break;
                      case true:
                        await ref.read(registerVmProvider.notifier).register(
                              name: _nameEC.text,
                              email: _emailEC.text,
                              password: _passwordEC.text,
                            );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(56),
                  ),
                  child: const Text("CRIAR CONTA"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
