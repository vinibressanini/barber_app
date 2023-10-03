import 'package:flutter/material.dart';

import 'day_button.dart';

class WorkDaysRow extends StatelessWidget {
  final ValueChanged<String> onDaySelected;

  const WorkDaysRow({
    super.key,
    required this.onDaySelected,
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
            ),
            DayButton(
              day: "Ter",
              onDaySelected: onDaySelected,
            ),
            DayButton(
              day: "Qua",
              onDaySelected: onDaySelected,
            ),
            DayButton(
              day: "Qui",
              onDaySelected: onDaySelected,
            ),
            DayButton(
              day: "Sex",
              onDaySelected: onDaySelected,
            ),
            DayButton(
              day: "Sab",
              onDaySelected: onDaySelected,
            ),
            DayButton(
              day: "Dom",
              onDaySelected: onDaySelected,
            ),
          ],
        ),
      ],
    );
  }
}
