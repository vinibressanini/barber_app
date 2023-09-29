import 'package:flutter/material.dart';

import '../constants.dart';

class HourButton extends StatelessWidget {
  final String label;

  const HourButton({
    required this.label,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: 64,
        height: 35,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: ColorsConstants.grey,
          ),
        ),
        child: Center(
            child: Text(
          label,
          style: const TextStyle(color: ColorsConstants.grey, fontSize: 12),
        )),
      ),
    );
  }
}
