import 'package:asyncstate/asyncstate.dart';
import 'package:barber_app/src/core/providers/application_providers.dart';
import 'package:barber_app/src/features/home/adm/admin_home_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/fp/either.dart';
import '../../../models/barbershop_model.dart';
import '../../../models/user_model.dart';

part 'admin_home_vm.g.dart';

@riverpod
class AdminHomeVm extends _$AdminHomeVm {
  @override
  Future<AdminHomeState> build() async {
    return await getEmployees();
  }

  Future<AdminHomeState> getEmployees() async {
    var repository = ref.read(userRepositoryProvider);
    final BarbershopModel(id: barbershopId) =
        await ref.read(getMyBarbershopProvider.future);

    final me = await ref.read(getMeProvider.future);

    var employeesResult = await repository.getEmployees(barbershopId);

    switch (employeesResult) {
      case Success(value: final employeesData):
        final employees = <UserModel>[];

        if (me case UserModelADM(workDays: _?, workHours: _?)) {
          employees.add(me);
        }

        employees.addAll(employeesData);
        return AdminHomeState(
            status: AdminHomeStateStatus.loaded, employees: employees);
      case Failure():
        return AdminHomeState(
            status: AdminHomeStateStatus.error, employees: []);
    }
  }

  Future<void> logout() async =>
      await ref.read(logoutProvider.future).asyncLoader();
}
