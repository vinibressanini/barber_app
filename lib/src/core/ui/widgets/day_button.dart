import 'package:flutter/material.dart';

import '../constants.dart';

class DayButton extends StatelessWidget {
  final String day;

  const DayButton({super.key, required this.day});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: 40,
        height: 56,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: ColorsConstants.grey,
          ),
        ),
        child: Center(
          child: Text(
            day,
            style: const TextStyle(
              fontSize: 12,
              color: ColorsConstants.grey,
            ),
          ),
        ),
      ),
    );
  }
}
