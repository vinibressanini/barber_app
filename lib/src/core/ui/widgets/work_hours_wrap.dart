import 'package:flutter/material.dart';

import 'hour_button.dart';

class WorkHoursWrap extends StatefulWidget {
  final int initalHour;
  final int finalHour;
  final ValueChanged<int> onHourSelected;
  final List<int>? enabledHours;
  final bool singleSelection;

  const WorkHoursWrap({
    super.key,
    required this.finalHour,
    required this.initalHour,
    required this.onHourSelected,
    this.enabledHours,
  }) : singleSelection = false;

  const WorkHoursWrap.singleSelection({
    super.key,
    required this.finalHour,
    required this.initalHour,
    required this.onHourSelected,
    this.enabledHours,
  }) : singleSelection = true;

  @override
  State<WorkHoursWrap> createState() => _WorkHoursWrapState();
}

class _WorkHoursWrapState extends State<WorkHoursWrap> {
  int? lastSelection;
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
            for (int i = widget.initalHour; i <= widget.finalHour; i++)
              HourButton(
                label: "${i.toString().padLeft(2, "0")}:00",
                value: i,
                enabledHours: widget.enabledHours,
                singleSelection: widget.singleSelection,
                selectedValue: lastSelection,
                onHourSelected: (timeSelected) {
                  setState(() {
                    if (widget.singleSelection) {
                      if (lastSelection == timeSelected) {
                        lastSelection = null;
                      } else {
                        lastSelection = timeSelected;
                      }
                    }
                    widget.onHourSelected(timeSelected);
                  });
                },
              ),
          ],
        ),
      ],
    );
  }
}
