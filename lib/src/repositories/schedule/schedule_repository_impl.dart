import 'dart:developer';

import 'package:barber_app/src/core/exceptions/repository_exception.dart';
import 'package:barber_app/src/core/fp/either.dart';
import 'package:barber_app/src/core/fp/nil.dart';
import 'package:barber_app/src/core/rest/rest_client.dart';
import 'package:barber_app/src/repositories/schedule/schedule_repository.dart';
import 'package:dio/dio.dart';

class ScheduleRepositoryImpl implements ScheduleRepository {
  final RestClient _restClient;

  ScheduleRepositoryImpl(this._restClient);

  @override
  Future<Either<RepositoryException, Nil>> register(
      ({
        int barbershopId,
        String customerName,
        DateTime date,
        int time,
        int userId
      }) customerData) async {
    try {
      await _restClient.auth.post("/schedules", data: {
        "barbershop_id": customerData.barbershopId,
        "user_id": customerData.userId,
        "client_name": customerData.customerName,
        "date": customerData.date.toIso8601String(),
        "time": customerData.time
      });

      return Success(nil);
    } on DioException catch (e, s) {
      log("[ERROR] Erro ao registrar o horário do cliente",
          error: e, stackTrace: s);
      return Failure(
          RepositoryException("Erro ao registrar o horário do usuário"));
    }
  }
}
