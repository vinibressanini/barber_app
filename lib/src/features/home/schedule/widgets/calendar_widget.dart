import 'package:barber_app/src/core/ui/constants.dart';
import 'package:barber_app/src/core/ui/helpers/messages.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarWidget extends StatefulWidget {
  final VoidCallback onCancelPressed;
  final ValueChanged<DateTime> onOkPressed;

  const CalendarWidget({
    super.key,
    required this.onCancelPressed,
    required this.onOkPressed,
  });

  @override
  State<CalendarWidget> createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  DateTime? selectedDay;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        color: Color(0xffe9e2e6),
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Column(
        children: [
          TableCalendar(
            calendarFormat: CalendarFormat.month,
            availableGestures: AvailableGestures.none,
            headerStyle: const HeaderStyle(titleCentered: true),
            locale: 'pt_BR',
            focusedDay: DateTime.now(),
            firstDay: DateTime.now(),
            lastDay: DateTime.now().add(
              const Duration(days: 365 * 2),
            ),
            availableCalendarFormats: const {
              CalendarFormat.month: "Month",
            },
            calendarStyle: CalendarStyle(
              todayDecoration: BoxDecoration(
                color: ColorsConstants.brown.withOpacity(0.5),
                shape: BoxShape.circle,
              ),
              selectedDecoration: const BoxDecoration(
                color: ColorsConstants.brown,
                shape: BoxShape.circle,
              ),
            ),
            selectedDayPredicate: (day) {
              return isSameDay(day, selectedDay);
            },
            onDaySelected: (selectedDay, focusedDay) {
              this.selectedDay = selectedDay;
              setState(() {});
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () => widget.onCancelPressed(),
                child: const Text(
                  "Cancelar",
                  style: TextStyle(
                    color: ColorsConstants.brown,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  if (selectedDay == null) {
                    Messages.showError(context, "Pof favor selecione uma data");
                    return;
                  }

                  widget.onOkPressed(selectedDay!);
                },
                child: const Text(
                  "OK",
                  style: TextStyle(
                    color: ColorsConstants.brown,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
