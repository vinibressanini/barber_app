import 'dart:developer';

import 'package:barber_app/src/core/exceptions/repository_exception.dart';
import 'package:barber_app/src/core/fp/either.dart';
import 'package:barber_app/src/core/fp/nil.dart';
import 'package:barber_app/src/core/rest/rest_client.dart';
import 'package:barber_app/src/models/barbershop_model.dart';
import 'package:barber_app/src/models/user_model.dart';
import 'package:barber_app/src/repositories/barbershop/barbershop_repository.dart';
import 'package:dio/dio.dart';

class BarbershopRepositoryImpl implements BarbershopRepository {
  final RestClient _restClient;

  BarbershopRepositoryImpl(this._restClient);

  @override
  Future<Either<RepositoryException, BarbershopModel>> getMyBarbershop(
      UserModel userModel) async {
    switch (userModel) {
      case UserModelADM():
        final Response(data: List(first: data)) = await _restClient.auth
            .get("/barbershop", queryParameters: {"user_id": "#userAuthRef"});

        return Success(BarbershopModel.fromMap(data));

      case UserModelEmployee():
        final Response(:data) = await _restClient.auth.get(
          "/barbershop/${userModel.barbershopId}",
        );

        return Success(BarbershopModel.fromMap(data));
    }
  }

  @override
  Future<Either<RepositoryException, Nil>> save(
      ({
        String name,
        String email,
        List<String> openingDays,
        List<int> openingHours
      }) data) async {
    try {
      await _restClient.auth.post("/barbershop", data: {
        "user_id": '#userAuthRef',
        "name": data.name,
        "email": data.email,
        "opening_hours": data.openingHours,
        "opening_days": data.openingDays,
      });

      return Success(nil);
    } on DioException catch (e, s) {
      log("[ERROR] Erro ao cadastar a barbearia", error: e, stackTrace: s);
      return Failure(RepositoryException("Erro ao cadastrar a barbearia"));
    }
  }
}
