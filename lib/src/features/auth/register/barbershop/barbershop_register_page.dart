import 'package:barber_app/src/core/ui/widgets/work_days_row.dart';
import 'package:barber_app/src/core/ui/widgets/work_hours_wrap.dart';
import 'package:flutter/material.dart';

class BarbershopRegisterPage extends StatefulWidget {
  const BarbershopRegisterPage({super.key});

  @override
  State<BarbershopRegisterPage> createState() => _BarbershopRegisterPageState();
}

class _BarbershopRegisterPageState extends State<BarbershopRegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastrar Estabelecimento'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(19),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 24),
              TextFormField(),
              const SizedBox(height: 24),
              TextFormField(),
              const SizedBox(height: 24),
              const WorkDaysRow(),
              const SizedBox(height: 24),
              const WorkHoursWrap(
                initalHour: 05,
                finalHour: 23,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(56),
                ),
                child: const Text("CADASTRAR ESTABELECIMENTO"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
