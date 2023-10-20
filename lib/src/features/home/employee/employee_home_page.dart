import 'package:barber_app/src/core/providers/application_providers.dart';
import 'package:barber_app/src/core/ui/constants.dart';
import 'package:barber_app/src/core/ui/widgets/avatar_widget.dart';
import 'package:barber_app/src/core/ui/widgets/barbershop_loader.dart';
import 'package:barber_app/src/features/home/employee/employee_home_provider.dart';
import 'package:barber_app/src/features/home/widgets/home_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/user_model.dart';

class EmployeeHomePage extends ConsumerWidget {
  const EmployeeHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(getMeProvider);
    return Scaffold(
      body: userAsync.when(
        error: (error, stackTrace) => const Center(
          child: Text("Erro ao carregar a página"),
        ),
        loading: () => const Center(
          child: BarbershopLoader(),
        ),
        data: (user) {
          final UserModel(:name, id: userId) = user;
          return CustomScrollView(
            slivers: [
              const SliverToBoxAdapter(
                child: HomeHeader.withoutFilter(),
              ),
              SliverFillRemaining(
                hasScrollBody: false,
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      const AvatarWidget(hideUploadIcon: true),
                      const SizedBox(height: 24),
                      Text(
                        name,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 24),
                      Container(
                        height: 108,
                        width: MediaQuery.sizeOf(context).width * 0.7,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: ColorsConstants.grey,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Consumer(builder: (context, ref, child) {
                              final totalSchedulesAsync = ref.watch(
                                  getTotalSchedulesTodayProvider(userId));
                              return totalSchedulesAsync.when(
                                skipLoadingOnRefresh: false,
                                loading: () =>
                                    const Center(child: BarbershopLoader()),
                                error: (error, stackTrace) => const Center(
                                    child: Text("Erro ao buscar informações")),
                                data: (total) {
                                  return Text(
                                    "$total",
                                    style: const TextStyle(
                                      fontSize: 32,
                                      color: ColorsConstants.brown,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  );
                                },
                              );
                            }),
                            const Text(
                              "Hoje",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: () => Navigator.of(context)
                            .pushNamed("/home/schedule", arguments: user),
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size.fromHeight(56),
                        ),
                        child: const Text("AGENDAR CLIENTE"),
                      ),
                      const SizedBox(height: 24),
                      OutlinedButton(
                        onPressed: () => Navigator.of(context)
                            .pushNamed("/employee/schedule", arguments: user),
                        style: OutlinedButton.styleFrom(
                          minimumSize: const Size.fromHeight(56),
                        ),
                        child: const Text("VER AGENDA"),
                      ),
                    ],
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
