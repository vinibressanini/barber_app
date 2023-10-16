import 'package:flutter/material.dart';

import '../constants.dart';

class HourButton extends StatefulWidget {
  final String label;
  final int value;
  final ValueChanged<int> onHourSelected;
  final List<int>? enabledHours;
  final bool singleSelection;
  final int? selectedValue;

  const HourButton({
    required this.value,
    required this.label,
    required this.onHourSelected,
    required this.singleSelection,
    required this.selectedValue,
    this.enabledHours,
    super.key,
  });

  @override
  State<HourButton> createState() => _HourButtonState();
}

class _HourButtonState extends State<HourButton> {
  bool selected = false;

  @override
  Widget build(BuildContext context) {
    final HourButton(:singleSelection, :selectedValue, :value) = widget;

    if (singleSelection) {
      if (selectedValue != null) {
        if (selectedValue == value) {
          selected = true;
        } else {
          selected = false;
        }
      }

      setState(() {});
    }

    var buttonColor = selected ? ColorsConstants.brown : Colors.white;

    var disableButton = widget.enabledHours != null &&
        !widget.enabledHours!.contains(widget.value);

    if (disableButton) {
      buttonColor = Colors.grey[400]!;
    }

    return InkWell(
      onTap: disableButton
          ? null
          : () => setState(() {
                widget.onHourSelected(widget.value);
                selected = !selected;
              }),
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: 64,
        height: 35,
        decoration: BoxDecoration(
          color: buttonColor,
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
