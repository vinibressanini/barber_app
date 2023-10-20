import 'package:barber_app/src/core/providers/application_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/fp/either.dart';

part 'employee_home_provider.g.dart';

@riverpod
Future<int> getTotalSchedulesToday(
    GetTotalSchedulesTodayRef ref, int userId) async {
  final repository = ref.read(scheduleRepositoryProvider);
  final DateTime(:year, :month, :day) = DateTime.now();

  final filter = (
    date: DateTime(year, month, day, 0, 0, 0),
    userId: userId,
  );

  final result = await repository.findScheduleByDate(filter);

  return switch (result) {
    Success(value: List(length: final totalSchedules)) => totalSchedules,
    Failure(:final exception) => throw exception
  };
}
