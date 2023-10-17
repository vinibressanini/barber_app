import 'package:barber_app/src/core/ui/constants.dart';
import 'package:barber_app/src/core/ui/helpers/messages.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarWidget extends StatefulWidget {
  final VoidCallback onCancelPressed;
  final ValueChanged<DateTime> onOkPressed;
  final List<String> enabledDays;

  const CalendarWidget({
    super.key,
    required this.onCancelPressed,
    required this.onOkPressed,
    required this.enabledDays,
  });

  @override
  State<CalendarWidget> createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  DateTime? selectedDay;
  late final workDays;

  convertWeekday(String weekday) {
    return switch (weekday.toLowerCase()) {
      "seg" => DateTime.monday,
      "ter" => DateTime.tuesday,
      "qua" => DateTime.wednesday,
      "qui" => DateTime.thursday,
      "sex" => DateTime.friday,
      "sab" => DateTime.saturday,
      "dom" => DateTime.sunday,
      _ => 0
    };
  }

  @override
  void initState() {
    workDays = widget.enabledDays.map((e) => convertWeekday(e)).toList();
    super.initState();
  }

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
            enabledDayPredicate: (day) {
              return workDays.contains(day.weekday);
            },
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
                    Messages.showError(context, "Por favor selecione uma data");
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
