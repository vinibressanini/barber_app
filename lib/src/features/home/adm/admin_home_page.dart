import 'package:barber_app/src/core/ui/barbershop_icons.dart';
import 'package:barber_app/src/core/ui/constants.dart';
import 'package:barber_app/src/features/home/adm/widgets/employee_container.dart';
import 'package:barber_app/src/features/home/widgets/home_header.dart';
import 'package:flutter/material.dart';

class AdminHomePage extends StatelessWidget {
  const AdminHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(
            child: HomeHeader(),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              childCount: 10,
              (context, index) => const EmployeeContainer(),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: ColorsConstants.brown,
        shape: const CircleBorder(),
        child: const CircleAvatar(
          backgroundColor: ColorsConstants.white,
          maxRadius: 14,
          child: Icon(
            BarbershopIcons.addEmployee,
            color: ColorsConstants.brown,
          ),
        ),
      ),
    );
  }
}
