import 'package:flutter/material.dart';

import 'hour_button.dart';

class WorkHoursWrap extends StatelessWidget {
  final int initalHour;
  final int finalHour;
  final ValueChanged<int> onHourSelected;

  const WorkHoursWrap({
    super.key,
    required this.finalHour,
    required this.initalHour,
    required this.onHourSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Selecione os horários de atendimento",
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 16),
        Wrap(
          runSpacing: 16,
          spacing: 8,
          children: [
            for (int i = initalHour; i <= finalHour; i++)
              HourButton(
                label: "${i.toString().padLeft(2, "0")}:00",
                value: i,
                onHourSelected: onHourSelected,
              ),
          ],
        ),
      ],
    );
  }
}
