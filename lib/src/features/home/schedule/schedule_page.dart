import 'package:barber_app/src/core/ui/barbershop_icons.dart';
import 'package:barber_app/src/core/ui/constants.dart';
import 'package:barber_app/src/core/ui/widgets/avatar_widget.dart';
import 'package:barber_app/src/core/ui/widgets/work_hours_wrap.dart';
import 'package:barber_app/src/features/home/employee/employee_home_provider.dart';
import 'package:barber_app/src/features/home/schedule/schedule_state.dart';
import 'package:barber_app/src/features/home/schedule/schedule_vm.dart';
import 'package:barber_app/src/features/home/schedule/widgets/calendar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:validatorless/validatorless.dart';

import '../../../core/ui/helpers/messages.dart';
import '../../../models/user_model.dart';

class SchedulePage extends ConsumerStatefulWidget {
  const SchedulePage({super.key});

  @override
  ConsumerState<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends ConsumerState<SchedulePage> {
  bool hideCalendar = true;
  final dateFormat = DateFormat("dd/MM/yyyy");
  final customerEC = TextEditingController();
  final dateEC = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    customerEC.dispose();
    dateEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scheduleVm = ref.watch(scheduleVmProvider.notifier);
    var userModel = ModalRoute.of(context)!.settings.arguments as UserModel;

    final employeeData = switch (userModel) {
      UserModelADM(:final workHours, :final workDays) => (
          workDays: workDays!,
          workHours: workHours!
        ),
      UserModelEmployee(:final workHours, :final workDays) => (
          workDays: workDays,
          workHours: workHours
        ),
    };

    ref.listen(scheduleVmProvider.select((state) => state.status), (_, status) {
      switch (status) {
        case ScheduleStateStatus.initial:
          break;
        case ScheduleStateStatus.success:
          Messages.showSuccess(context, "Cliente agendado com sucesso!");
          ref.invalidate(getTotalSchedulesTodayProvider);
          Navigator.of(context).pop();
          break;
        case ScheduleStateStatus.error:
          Messages.showError(
              context, "Ocorreu um erro ao agendar o cliente. Tente novamente");
          break;
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Agendar Cliente'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Center(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  const AvatarWidget(hideUploadIcon: true),
                  const SizedBox(height: 36),
                  Text(
                    userModel.name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 36),
                  TextFormField(
                    controller: customerEC,
                    validator: Validatorless.required('Cliente obrigatório'),
                    decoration: const InputDecoration(
                      label: Text("Cliente"),
                    ),
                  ),
                  const SizedBox(height: 36),
                  TextFormField(
                    controller: dateEC,
                    validator: Validatorless.required('Data obrigatória'),
                    readOnly: true,
                    onTap: () => setState(() {
                      hideCalendar = false;
                      FocusScope.of(context).unfocus();
                    }),
                    decoration: const InputDecoration(
                      label: Text("Selecione Uma Data"),
                      hintText: "Selecione Uma Data",
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      suffixIcon: Icon(
                        BarbershopIcons.calendar,
                        color: ColorsConstants.brown,
                        size: 18,
                      ),
                    ),
                  ),
                  Offstage(
                    offstage: hideCalendar,
                    child: Column(
                      children: [
                        const SizedBox(height: 36),
                        CalendarWidget(
                          enabledDays: employeeData.workDays,
                          onCancelPressed: () {
                            setState(() {});
                            hideCalendar = true;
                          },
                          onOkPressed: (selectedDate) {
                            setState(() {
                              dateEC.text = dateFormat.format(selectedDate);
                              scheduleVm.dateSelect(selectedDate);

                              hideCalendar = true;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 36),
                  WorkHoursWrap.singleSelection(
                      finalHour: 23,
                      initalHour: 06,
                      onHourSelected: (hour) => scheduleVm.hourSelect(hour),
                      enabledHours: employeeData.workHours),
                  const SizedBox(height: 36),
                  ElevatedButton(
                    onPressed: () {
                      switch (formKey.currentState?.validate()) {
                        case (null || false):
                          Messages.showError(context, 'Campos Inválidos');
                          break;
                        case true:
                          final isHourSelected = ref.watch(scheduleVmProvider
                              .select((state) => state.scheduleHour != null));

                          if (isHourSelected) {
                            scheduleVm.register(
                                user: userModel, customer: customerEC.text);
                          } else {
                            Messages.showError(context,
                                'Por favor informe uma hora para o atendimento');
                          }

                          break;
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(56),
                    ),
                    child: const Text("CONFIRMAR AGENDAMENTO"),
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
