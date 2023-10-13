import 'package:flutter/material.dart';

import '../constants.dart';

class DayButton extends StatefulWidget {
  final String day;
  final ValueChanged<String> onDaySelected;
  final List<String>? enabledDays;

  const DayButton({
    super.key,
    required this.day,
    required this.onDaySelected,
    this.enabledDays,
  });

  @override
  State<DayButton> createState() => _DayButtonState();
}

class _DayButtonState extends State<DayButton> {
  bool selected = false;
  @override
  Widget build(BuildContext context) {
    var buttonColor = selected ? ColorsConstants.brown : Colors.white;

    bool disableDay =
        widget.enabledDays != null && !widget.enabledDays!.contains(widget.day);

    if (disableDay) {
      buttonColor = Colors.grey[400]!;
    }

    return InkWell(
      onTap: disableDay
          ? null
          : () => setState(() {
                widget.onDaySelected(widget.day);
                selected = !selected;
              }),
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: 40,
        height: 56,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: buttonColor,
          border: Border.all(
            color: ColorsConstants.grey,
          ),
        ),
        child: Center(
          child: Text(
            widget.day,
            style: TextStyle(
              fontSize: 12,
              color: selected ? ColorsConstants.white : Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}
