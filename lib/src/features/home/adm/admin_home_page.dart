import 'dart:developer';

import 'package:barber_app/src/core/ui/barbershop_icons.dart';
import 'package:barber_app/src/core/ui/constants.dart';
import 'package:barber_app/src/core/ui/widgets/barbershop_loader.dart';
import 'package:barber_app/src/features/home/adm/admin_home_vm.dart';
import 'package:barber_app/src/features/home/adm/widgets/employee_container.dart';
import 'package:barber_app/src/features/home/widgets/home_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AdminHomePage extends ConsumerStatefulWidget {
  const AdminHomePage({super.key});

  @override
  ConsumerState<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends ConsumerState<AdminHomePage> {
  @override
  Widget build(BuildContext context) {
    var employees = ref.watch(adminHomeVmProvider);

    Future<void> refresh() async {
      var adminVm = ref.read(adminHomeVmProvider.notifier);

      await adminVm.getEmployees();
    }

    return Scaffold(
      body: employees.when(
        data: (data) {
          return RefreshIndicator.adaptive(
            onRefresh: () => refresh(),
            child: CustomScrollView(
              slivers: [
                const SliverToBoxAdapter(
                  child: HomeHeader(),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    childCount: data.employees.length,
                    (context, index) => EmployeeContainer(
                      employee: data.employees[index],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        loading: () => const Center(
          child: BarbershopLoader(),
        ),
        error: (error, stackTrace) {
          log("[ERROR] Erro ao exibir a lista de colaboradores da barbearia",
              error: error, stackTrace: stackTrace);
          return const Center(
            child: Text(
              "Ops! Ocorreu um erro ao exibir a lista de colaboradores. Tente novamente",
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.of(context).pushNamed("/auth/register/employee");
          ref.invalidate(adminHomeVmProvider);
        },
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
