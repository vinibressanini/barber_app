import 'package:flutter/material.dart';

import 'day_button.dart';

class WorkDaysRow extends StatelessWidget {
  final ValueChanged<String> onDaySelected;
  final List<String>? enabledDays;

  const WorkDaysRow({
    super.key,
    required this.onDaySelected,
    this.enabledDays,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Selecione os dias da semana",
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            DayButton(
              day: "Seg",
              onDaySelected: onDaySelected,
              enabledDays: enabledDays,
            ),
            DayButton(
              day: "Ter",
              onDaySelected: onDaySelected,
              enabledDays: enabledDays,
            ),
            DayButton(
              day: "Qua",
              onDaySelected: onDaySelected,
              enabledDays: enabledDays,
            ),
            DayButton(
              day: "Qui",
              onDaySelected: onDaySelected,
              enabledDays: enabledDays,
            ),
            DayButton(
              day: "Sex",
              onDaySelected: onDaySelected,
              enabledDays: enabledDays,
            ),
            DayButton(
              day: "Sab",
              onDaySelected: onDaySelected,
              enabledDays: enabledDays,
            ),
            DayButton(
              day: "Dom",
              onDaySelected: onDaySelected,
              enabledDays: enabledDays,
            ),
          ],
        ),
      ],
    );
  }
}
