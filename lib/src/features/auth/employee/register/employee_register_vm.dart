import 'package:asyncstate/asyncstate.dart';
import 'package:barber_app/src/core/exceptions/repository_exception.dart';
import 'package:barber_app/src/core/fp/either.dart';
import 'package:barber_app/src/core/providers/application_providers.dart';
import 'package:barber_app/src/features/auth/employee/register/employee_register_state.dart';
import 'package:barber_app/src/models/barbershop_model.dart';
import 'package:barber_app/src/repositories/user/user_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/fp/nil.dart';

part 'employee_register_vm.g.dart';

@riverpod
class EmployeeRegisterVm extends _$EmployeeRegisterVm {
  @override
  EmployeeRegisterState build() => EmployeeRegisterState.initial();

  void setIsAdminFlag(bool isAdmRegister) {
    state = state.copyWith(isAdmRegister: isAdmRegister);
  }

  void addOrRemoveWorkDay(String day) {
    final EmployeeRegisterState(:workDays) = state;

    if (workDays.contains(day)) {
      workDays.remove(day);
    } else {
      workDays.add(day);
    }

    state = state.copyWith(workDays: workDays);
  }

  void addOrRemoveWorkHour(int hour) {
    final EmployeeRegisterState(:workHours) = state;

    if (workHours.contains(hour)) {
      workHours.remove(hour);
    } else {
      workHours.add(hour);
    }

    state = state.copyWith(workHours: workHours);
  }

  Future<void> register({String? name, String? email, String? password}) async {
    final asyncLoader = AsyncLoaderHandler()..start();

    final UserRepository(:registerEmployee, :registerAdmAsEmployee) =
        ref.read(userRepositoryProvider);

    final EmployeeRegisterState(:workDays, :workHours, :isAdmRegister) = state;

    final Either<RepositoryException, Nil> registerResult;

    if (isAdmRegister) {
      final dto = (
        workDays: workDays,
        workHours: workHours,
      );

      registerResult = await registerAdmAsEmployee(dto);
    } else {
      final BarbershopModel(:id) =
          await ref.read(getMyBarbershopProvider.future);
      final dto = (
        barbershopId: id,
        name: name!,
        email: email!,
        password: password!,
        workDays: workDays,
        workHours: workHours
      );

      registerResult = await registerEmployee(dto);
    }

    switch (registerResult) {
      case Success():
        state = state.copyWith(status: EmployeeRegisterStateStatus.success);
        break;
      case Failure():
        state = state.copyWith(status: EmployeeRegisterStateStatus.failure);
        break;
    }

    asyncLoader.close();
  }
}
