import 'package:flutter/material.dart';

import '../constants.dart';

class HourButton extends StatefulWidget {
  final String label;
  final int value;
  final ValueChanged<int> onHourSelected;

  const HourButton({
    required this.value,
    required this.label,
    required this.onHourSelected,
    super.key,
  });

  @override
  State<HourButton> createState() => _HourButtonState();
}

class _HourButtonState extends State<HourButton> {
  bool selected = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => setState(() {
        widget.onHourSelected(widget.value);
        selected = !selected;
      }),
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: 64,
        height: 35,
        decoration: BoxDecoration(
          color: selected ? ColorsConstants.brown : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: ColorsConstants.grey,
          ),
        ),
        child: Center(
            child: Text(
          widget.label,
          style: TextStyle(
              color: selected ? Colors.white : ColorsConstants.grey,
              fontSize: 12),
        )),
      ),
    );
  }
}
