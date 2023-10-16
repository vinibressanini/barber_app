import 'package:barber_app/src/core/ui/barbershop_icons.dart';
import 'package:barber_app/src/core/ui/constants.dart';
import 'package:barber_app/src/core/ui/widgets/avatar_widget.dart';
import 'package:barber_app/src/core/ui/widgets/work_hours_wrap.dart';
import 'package:barber_app/src/features/home/schedule/schedule_vm.dart';
import 'package:barber_app/src/features/home/schedule/widgets/calendar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:validatorless/validatorless.dart';

import '../../../core/ui/helpers/messages.dart';

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
                  const Text(
                    "Nome e Sobrenome",
                    style: TextStyle(
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
                    enabledHours: const [
                      06,
                      07,
                      08,
                      09,
                      12,
                      13,
                      14,
                      15,
                      16,
                      17,
                      18,
                      19
                    ],
                  ),
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

                          print(isHourSelected);

                          if (isHourSelected) {
                            //register
                          } else {
                            Messages.showError(context,
                                'Por favor informe uma hora para o atendimento');
                          }

                          int? value =
                              ref.read(scheduleVmProvider).scheduleHour;

                          print(value);

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
