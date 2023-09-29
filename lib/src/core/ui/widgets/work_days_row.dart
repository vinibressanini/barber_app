import 'package:flutter/material.dart';

import 'day_button.dart';

class WorkDaysRow extends StatelessWidget {
  const WorkDaysRow({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Selecione os dias da semana",
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
        ),
        SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            DayButton(day: "Seg"),
            DayButton(day: "Ter"),
            DayButton(day: "Qua"),
            DayButton(day: "Qui"),
            DayButton(day: "Sex"),
            DayButton(day: "Sab"),
            DayButton(day: "Dom"),
          ],
        ),
      ],
    );
  }
}
