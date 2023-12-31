import 'package:barber_app/src/core/ui/barbershop_icons.dart';
import 'package:barber_app/src/core/ui/constants.dart';
import 'package:barber_app/src/models/user_model.dart';
import 'package:flutter/material.dart';

class EmployeeContainer extends StatelessWidget {
  final UserModel employee;

  const EmployeeContainer({super.key, required this.employee});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 200,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: ColorsConstants.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Container(
            width: 56,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: switch (employee.avatar) {
                  final avatar? => NetworkImage(avatar),
                  _ => const AssetImage(ImageConstants.avatar)
                } as ImageProvider,
              ),
            ),
          ),
          const SizedBox(width: 5),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  employee.name,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () => Navigator.of(context)
                          .pushNamed("/home/schedule", arguments: employee),
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 12)),
                      child: const Text("AGENDAR"),
                    ),
                    OutlinedButton(
                      onPressed: () =>
                          Navigator.of(context).pushNamed("/employee/schedule",arguments: employee),
                      style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 12)),
                      child: const Text("VER AGENDA"),
                    ),
                    const Icon(
                      BarbershopIcons.penEdit,
                      size: 16,
                      color: ColorsConstants.brown,
                    ),
                    const Icon(
                      BarbershopIcons.trash,
                      size: 16,
                      color: ColorsConstants.red,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
