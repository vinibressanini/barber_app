import 'dart:developer';

import 'package:barber_app/src/core/ui/constants.dart';
import 'package:barber_app/src/core/ui/widgets/barbershop_loader.dart';
import 'package:barber_app/src/features/auth/employee/schedule/appontment_ds.dart';
import 'package:barber_app/src/features/auth/employee/schedule/employee_schedule_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../../../models/user_model.dart';

class EmployeeSchedulePage extends ConsumerStatefulWidget {
  const EmployeeSchedulePage({super.key});

  @override
  ConsumerState<EmployeeSchedulePage> createState() =>
      _EmployeeSchedulePageState();
}

class _EmployeeSchedulePageState extends ConsumerState<EmployeeSchedulePage> {
  late DateTime selectedDate;
  bool ignoreFirstCall = true;

  @override
  void initState() {
    final DateTime(:year, :month, :day) = DateTime.now();
    selectedDate = DateTime(year, month, day, 0, 0, 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final UserModel(id: userId, :name) =
        ModalRoute.of(context)!.settings.arguments as UserModel;
    final asyncSchedule =
        ref.watch(employeeScheduleVmProvider(userId, selectedDate));

    return Scaffold(
        appBar: AppBar(
          title: const Text('Agenda'),
        ),
        body: asyncSchedule.when(
          loading: () => const BarbershopLoader(),
          error: (error, stackTrace) {
            log("Erro ao exibir a agenda do colaborador",
                error: error, stackTrace: stackTrace);
            return const Center(
              child: Text("Erro ao carregar a agenda"),
            );
          },
          data: (data) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 44),
                  Expanded(
                    child: SfCalendar(
                      allowViewNavigation: true,
                      onViewChanged: (viewChangedDetails) async {
                        if (ignoreFirstCall) {
                          ignoreFirstCall = false;
                          return;
                        }
                        final DateTime(:year, :month, :day) =
                            viewChangedDetails.visibleDates.first;
                        selectedDate = DateTime(year, month, day, 0, 0, 0);
                        await ref
                            .watch(
                                employeeScheduleVmProvider(userId, selectedDate)
                                    .notifier)
                            .changeDate(userId, selectedDate);
                      },
                      view: CalendarView.day,
                      showNavigationArrow: true,
                      todayHighlightColor: ColorsConstants.brown,
                      showDatePickerButton: true,
                      showTodayButton: true,
                      dataSource: AppontmentDs(data),
                      appointmentBuilder:
                          (context, calendarAppointmentDetails) {
                        var appointment =
                            calendarAppointmentDetails.appointments.first;
                        return Container(
                          decoration: BoxDecoration(
                            color: ColorsConstants.brown,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Center(
                            child: Text(
                              appointment.subject,
                              style: const TextStyle(
                                  fontSize: 13, color: Colors.white),
                            ),
                          ),
                        );
                      },
                      onTap: (calendarTapDetails) {
                        if (calendarTapDetails.appointments != null &&
                            calendarTapDetails.appointments!.isNotEmpty) {
                          final dateFormat = DateFormat("dd/MM/yyyy '-' hh:mm");
                          final appointment =
                              calendarTapDetails.appointments!.first;
                          showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return SizedBox(
                                height: 150,
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(appointment.subject),
                                      Text(
                                        dateFormat
                                            .format(calendarTapDetails.date!),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ));
  }
}
