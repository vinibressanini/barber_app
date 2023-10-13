import 'package:barber_app/src/core/providers/application_providers.dart';
import 'package:barber_app/src/core/ui/barbershop_icons.dart';
import 'package:barber_app/src/core/ui/constants.dart';
import 'package:barber_app/src/core/ui/widgets/barbershop_loader.dart';
import 'package:barber_app/src/features/home/adm/admin_home_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeHeader extends ConsumerWidget {
  final bool showFilter;

  const HomeHeader({super.key, this.showFilter = true});
  const HomeHeader.withoutFilter({super.key, this.showFilter = false});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var barbershop = ref.watch(getMyBarbershopProvider);
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(32), bottomRight: Radius.circular(32)),
        image: DecorationImage(
          image: AssetImage(ImageConstants.chairImageBg),
          fit: BoxFit.cover,
          opacity: 0.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          barbershop.maybeWhen(
              orElse: () => const Center(
                    child: BarbershopLoader(),
                  ),
              data: (barbershopState) {
                return Row(
                  children: [
                    const CircleAvatar(
                      backgroundColor: ColorsConstants.grey,
                      child: SizedBox.shrink(),
                    ),
                    const SizedBox(width: 16),
                    Flexible(
                      child: Text(
                        barbershopState.name,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    const Expanded(
                      child: Text(
                        "editar",
                        style: TextStyle(
                          color: ColorsConstants.brown,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () async =>
                          ref.read(adminHomeVmProvider.notifier).logout(),
                      icon: const Icon(
                        BarbershopIcons.exit,
                        color: ColorsConstants.brown,
                        size: 32,
                      ),
                    ),
                  ],
                );
              }),
          const SizedBox(height: 24),
          const Text(
            "Bem-Vindo",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            "Agende um Cliente",
            style: TextStyle(
              color: Colors.white,
              fontSize: 40,
              fontWeight: FontWeight.w600,
            ),
          ),
          Offstage(
            offstage: !showFilter,
            child: const SizedBox(height: 24),
          ),
          Offstage(
            offstage: !showFilter,
            child: TextFormField(
              onTapOutside: (event) => FocusScope.of(context).unfocus(),
              decoration: const InputDecoration(
                label: Text("Buscar Colaborador"),
                suffixIcon: Padding(
                  padding: EdgeInsets.only(right: 24),
                  child: Icon(
                    BarbershopIcons.search,
                    color: ColorsConstants.brown,
                    size: 26,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
