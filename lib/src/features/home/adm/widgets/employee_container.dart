import 'package:barber_app/src/core/ui/barbershop_icons.dart';
import 'package:barber_app/src/core/ui/constants.dart';
import 'package:flutter/material.dart';

class EmployeeContainer extends StatelessWidget {
  const EmployeeContainer({super.key});

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
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(ImageConstants.avatar),
              ),
            ),
          ),
          const SizedBox(width: 5),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Nome e Sobrenome",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 12)),
                      child: const Text("AGENDAR"),
                    ),
                    OutlinedButton(
                      onPressed: () {},
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
