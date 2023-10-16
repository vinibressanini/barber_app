import 'package:asyncstate/asyncstate.dart';
import 'package:barber_app/src/core/fp/either.dart';
import 'package:barber_app/src/core/providers/application_providers.dart';
import 'package:barber_app/src/features/home/schedule/schedule_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../models/barbershop_model.dart';
import '../../../models/user_model.dart';

part 'schedule_vm.g.dart';

@riverpod
class ScheduleVm extends _$ScheduleVm {
  @override
  ScheduleState build() => ScheduleState.initial();

  void hourSelect(int? hour) {
    if (hour == state.scheduleHour) {
      state = state.copyWith(scheduleHour: () => null);
    } else {
      state = state.copyWith(scheduleHour: () => hour);
    }
  }

  void dateSelect(DateTime date) {
    state = state.copyWith(scheduleDate: () => date);
  }

  Future<void> register(
      {required UserModel user, required String customer}) async {
    final asyncLoader = AsyncLoaderHandler()..start();

    final ScheduleState(:scheduleDate, :scheduleHour) = state;

    final BarbershopModel(:id) =
        await ref.watch(getMyBarbershopProvider.future);

    final scheduleRepo = ref.read(scheduleRepositoryProvider);

    final dto = (
      barbershopId: id,
      userId: user.id,
      customerName: customer,
      date: scheduleDate!,
      time: scheduleHour!
    );

    final registerResult = await scheduleRepo.register(dto);

    switch (registerResult) {
      case Success():
        state = state.copyWith(status: ScheduleStateStatus.success);
        break;
      case Failure():
        state = state.copyWith(status: ScheduleStateStatus.error);
    }

    asyncLoader.close();
  }
}
