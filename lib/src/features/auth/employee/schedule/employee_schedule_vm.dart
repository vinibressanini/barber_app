import 'package:barber_app/src/core/exceptions/repository_exception.dart';
import 'package:barber_app/src/core/fp/either.dart';
import 'package:barber_app/src/core/providers/application_providers.dart';
import 'package:barber_app/src/models/schedule_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'employee_schedule_vm.g.dart';

@riverpod
class EmployeeScheduleVm extends _$EmployeeScheduleVm {
  @override
  Future<List<ScheduleModel>> build(int userId, DateTime date) async {
    final result = await _getSchedules(userId, date);

    switch (result) {
      case Success(:final value):
        return value;
      case Failure(:final exception):
        throw Exception(exception);
    }
  }

  Future<Either<RepositoryException, List<ScheduleModel>>> _getSchedules(
      int userId, DateTime date) async {
    final dto = (userId: userId, date: date);

    return await ref.read(scheduleRepositoryProvider).findScheduleByDate(dto);
  }

  Future<void> changeDate(int userId, DateTime date) async {
    final result = await _getSchedules(userId, date);

    state = switch (result) {
      Success(:final value) => AsyncData(value),
      Failure(:final exception) =>
        AsyncError(Exception(exception), StackTrace.current)
    };
  }
}
