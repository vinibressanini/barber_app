import 'package:barber_app/src/core/ui/constants.dart';
import 'package:barber_app/src/features/auth/employee/schedule/appontment_ds.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class EmployeeSchedulePage extends StatelessWidget {
  const EmployeeSchedulePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agenda'),
      ),
      body: Column(
        children: [
          const Text(
            "Nome e Sobrenome",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 44),
          Expanded(
            child: SfCalendar(
              allowViewNavigation: true,
              view: CalendarView.day,
              showNavigationArrow: true,
              todayHighlightColor: ColorsConstants.brown,
              showDatePickerButton: true,
              showTodayButton: true,
              dataSource: AppontmentDs(),
              appointmentBuilder: (context, calendarAppointmentDetails) {
                var appointment = calendarAppointmentDetails.appointments.first;
                return Container(
                  decoration: BoxDecoration(
                    color: ColorsConstants.brown,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(
                    child: Text(
                      appointment.subject,
                      style: const TextStyle(fontSize: 13, color: Colors.white),
                    ),
                  ),
                );
              },
              onTap: (calendarTapDetails) {
                if (calendarTapDetails.appointments != null &&
                    calendarTapDetails.appointments!.isNotEmpty) {
                  final dateFormat = DateFormat("dd/MM/yyyy '-' hh:mm");
                  final appointment = calendarTapDetails.appointments!.first;
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
                                dateFormat.format(calendarTapDetails.date!),
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
  }
}
