import 'package:barber_app/src/core/ui/widgets/work_days_row.dart';
import 'package:barber_app/src/core/ui/widgets/work_hours_wrap.dart';
import 'package:barber_app/src/features/auth/register/barbershop/barbershop_register_state.dart';
import 'package:barber_app/src/features/auth/register/barbershop/barbershop_register_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:validatorless/validatorless.dart';

import '../../../../core/ui/helpers/messages.dart';

class BarbershopRegisterPage extends ConsumerStatefulWidget {
  const BarbershopRegisterPage({super.key});

  @override
  ConsumerState<BarbershopRegisterPage> createState() =>
      _BarbershopRegisterPageState();
}

class _BarbershopRegisterPageState
    extends ConsumerState<BarbershopRegisterPage> {
  final _nameEC = TextEditingController();
  final _emailEC = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _nameEC.dispose();
    _emailEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final barbershopVm = ref.read(barbershopRegisterVmProvider.notifier);

    ref.listen(barbershopRegisterVmProvider, (_, state) {
      switch (state.status) {
        case BarbershopRegisterStateStatus.initial:
          break;
        case BarbershopRegisterStateStatus.successful:
          Messages.showSuccess(context, "Barbearia criada com sucesso!");
          Navigator.of(context)
              .pushNamedAndRemoveUntil('/barbershop_test', (route) => false);
          break;
        case BarbershopRegisterStateStatus.failure:
          Messages.showError(
              context, "Erro ao criar a barbearia. Tente novamente");
          break;
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastrar Estabelecimento'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(19),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 24),
                TextFormField(
                  controller: _nameEC,
                  decoration: const InputDecoration(label: Text('Nome')),
                  validator:
                      Validatorless.required("O campo nome é obrigatório"),
                ),
                const SizedBox(height: 24),
                TextFormField(
                  controller: _emailEC,
                  decoration: const InputDecoration(label: Text("E-mail")),
                  validator: Validatorless.multiple([
                    Validatorless.required("O campo email é obrigatório"),
                    Validatorless.email("Informe um email válido"),
                  ]),
                ),
                const SizedBox(height: 24),
                WorkDaysRow(
                  onDaySelected: (value) {
                    barbershopVm.addOrRemoveWorkDay(value);
                  },
                ),
                const SizedBox(height: 24),
                WorkHoursWrap(
                  initalHour: 05,
                  finalHour: 23,
                  onHourSelected: (value) {
                    barbershopVm.addOrRemoveWorkingHours(value);
                  },
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState != null) {
                      switch (_formKey.currentState!.validate()) {
                        case true:
                          barbershopVm.save(_nameEC.text, _emailEC.text);
                          break;
                        case false:
                          break;
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(56),
                  ),
                  child: const Text("CADASTRAR ESTABELECIMENTO"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
