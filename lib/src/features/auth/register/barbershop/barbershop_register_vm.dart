import 'package:barber_app/src/core/fp/either.dart';
import 'package:barber_app/src/core/providers/application_providers.dart';
import 'package:barber_app/src/features/auth/register/barbershop/barbershop_register_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'barbershop_register_vm.g.dart';

@riverpod
class BarbershopRegisterVm extends _$BarbershopRegisterVm {
  @override
  BarbershopRegisterState build() => BarbershopRegisterState.initial();

  void addOrRemoveWorkDay(String dayOfTheWeek) {
    final openingDays = state.openingDays;

    openingDays.contains(dayOfTheWeek)
        ? openingDays.remove(dayOfTheWeek)
        : openingDays.add(dayOfTheWeek);
  }

  void addOrRemoveWorkingHours(int hourOfTheday) {
    final openingHours = state.openingHours;

    openingHours.contains(hourOfTheday)
        ? openingHours.remove(hourOfTheday)
        : openingHours.add(hourOfTheday);
  }

  Future<void> save(String name, String email) async {
    var repository = ref.read(barbershopRepositoryProvider);
    var BarbershopRegisterState(:openingDays, :openingHours) = state;

    var barbershopDto = (
      name: name,
      email: email,
      openingDays: openingDays,
      openingHours: openingHours
    );

    var barbershopCreateResult = await repository.save(barbershopDto);

    switch (barbershopCreateResult) {
      case Success():
        ref.invalidate(getMyBarbershopProvider);
        state =
            state.copyWith(status: BarbershopRegisterStateStatus.successful);
        break;
      case Failure():
        state = state.copyWith(status: BarbershopRegisterStateStatus.failure);
        break;
    }
  }
}
