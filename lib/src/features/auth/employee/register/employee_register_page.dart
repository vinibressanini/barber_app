import 'package:barber_app/src/core/providers/application_providers.dart';
import 'package:barber_app/src/core/ui/widgets/barbershop_loader.dart';
import 'package:barber_app/src/core/ui/widgets/work_days_row.dart';
import 'package:barber_app/src/features/auth/employee/register/employee_register_state.dart';
import 'package:barber_app/src/features/auth/employee/register/employee_register_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:validatorless/validatorless.dart';

import '../../../../core/ui/helpers/messages.dart';
import '../../../../core/ui/widgets/avatar_widget.dart';
import '../../../../core/ui/widgets/work_hours_wrap.dart';

class EmployeeRegisterPage extends ConsumerStatefulWidget {
  const EmployeeRegisterPage({super.key});

  @override
  ConsumerState<EmployeeRegisterPage> createState() =>
      _EmployeeRegisterPageState();
}

class _EmployeeRegisterPageState extends ConsumerState<EmployeeRegisterPage> {
  bool isAdmRegister = false;
  final _nameEC = TextEditingController();
  final _emailEC = TextEditingController();
  final _passwordEC = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _nameEC.dispose();
    _emailEC.dispose();
    _passwordEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var barbershop = ref.read(getMyBarbershopProvider);
    var employeeVm = ref.read(employeeRegisterVmProvider.notifier);

    ref.listen(
      employeeRegisterVmProvider.select((state) => state.status),
      (_, status) {
        switch (status) {
          case EmployeeRegisterStateStatus.initial:
            break;
          case EmployeeRegisterStateStatus.success:
            Messages.showSuccess(context, "Colaborador cadastrado com sucesso");
            Navigator.of(context).pop();
            break;
          case EmployeeRegisterStateStatus.failure:
            Messages.showError(context, "Erro ao cadastrar colaborador");
            break;
        }
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastrar Colaborador'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Center(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const AvatarWidget(),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Checkbox.adaptive(
                          value: isAdmRegister,
                          onChanged: (value) {
                            setState(() {
                              isAdmRegister = !isAdmRegister;
                              employeeVm.setIsAdminFlag(isAdmRegister);
                            });
                          }),
                      const Expanded(
                        child: Text(
                          "Sou administrador e quero me cadastrar como colaborador",
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Offstage(
                    offstage: isAdmRegister,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _nameEC,
                          decoration: const InputDecoration(
                            label: Text("Nome"),
                          ),
                          validator: Validatorless.required(
                              "Este campo é obrigatório"),
                        ),
                        const SizedBox(height: 24),
                        TextFormField(
                          controller: _emailEC,
                          decoration: const InputDecoration(
                            label: Text("E-mail"),
                          ),
                          validator: Validatorless.multiple([
                            Validatorless.required("Este campo é obrigatório"),
                            Validatorless.email('Informe um email válido'),
                          ]),
                        ),
                        const SizedBox(height: 24),
                        TextFormField(
                          controller: _passwordEC,
                          obscureText: true,
                          decoration: const InputDecoration(
                            label: Text("Senha"),
                          ),
                          validator: Validatorless.multiple([
                            Validatorless.min(6,
                                "A senha deve conter no minímo 6 caracteres"),
                            Validatorless.required("Este campo é obrigatório"),
                          ]),
                        ),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                  barbershop.maybeWhen(
                    data: (data) => Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: WorkDaysRow(
                            onDaySelected: (String day) =>
                                employeeVm.addOrRemoveWorkDay(day),
                            enabledDays: data.openingDays,
                          ),
                        ),
                        const SizedBox(height: 24),
                        WorkHoursWrap(
                          finalHour: 23,
                          initalHour: 5,
                          onHourSelected: (int hour) =>
                              employeeVm.addOrRemoveWorkHour(hour),
                          enabledHours: data.openingHours,
                        ),
                      ],
                    ),
                    orElse: () => const Center(
                      child: BarbershopLoader(),
                    ),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(56),
                    ),
                    onPressed: () async {
                      final EmployeeRegisterState(:workDays, :workHours) =
                          ref.watch(employeeRegisterVmProvider);
                      if (workDays.isEmpty || workHours.isEmpty) {
                        Messages.showError(context,
                            "Informe ao menos uma data e um horário de trabalho");
                      } else {
                        if (!isAdmRegister) {
                          switch (_formKey.currentState?.validate()) {
                            case (null || false):
                              Messages.showError(context, "Campos Inválidos");
                              break;
                            case true:
                              await employeeVm.register(
                                name: _nameEC.text,
                                email: _emailEC.text,
                                password: _passwordEC.text,
                              );
                              break;
                          }
                        } else {
                          await employeeVm.register();
                        }
                      }
                    },
                    child: const Text("CADASTRAR COLABORADOR"),
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
