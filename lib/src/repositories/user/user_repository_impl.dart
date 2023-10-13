import 'dart:developer';
import 'dart:io';

import 'package:barber_app/src/core/exceptions/auth_exception.dart';
import 'package:barber_app/src/core/exceptions/repository_exception.dart';
import 'package:barber_app/src/core/fp/either.dart';
import 'package:barber_app/src/core/fp/nil.dart';
import 'package:barber_app/src/core/rest/rest_client.dart';
import 'package:barber_app/src/models/user_model.dart';
import 'package:barber_app/src/repositories/user/user_repository.dart';
import 'package:dio/dio.dart';

class UserRepositoryImpl implements UserRepository {
  final RestClient _restClient;

  UserRepositoryImpl(this._restClient);

  @override
  Future<Either<AuthException, String>> login(
      String email, String password) async {
    try {
      final Response(:data) = await _restClient.unauth
          .post("/auth", data: {"email": email, "password": password});

      return Success(data["access_token"]);
    } on DioException catch (e, s) {
      if (e.response != null) {
        var statusCode = e.response!.statusCode;

        if (statusCode == HttpStatus.forbidden) {
          log("Login ou senha inválidos", error: e, stackTrace: s);
          return Failure(
              UnauthorizedAuthException(message: 'Login ou senha inválidos'));
        }
      }
      log("Error ao realizar login", error: e, stackTrace: s);
      return Failure(AuthError(message: "Error ao realizar login"));
    }
  }

  @override
  Future<Either<RepositoryException, UserModel>> me() async {
    try {
      final Response(:data) = await _restClient.auth.get("/me");
      return Success(UserModel.fromMap(data));
    } on DioException catch (e, s) {
      log("Error ao buscar dados do usuário", error: e, stackTrace: s);
      return Failure(RepositoryException("Error ao buscar dados do usuário"));
    } on ArgumentError catch (e, s) {
      log("[ERROR] Invalid JSON", error: e, stackTrace: s);
      return Failure(RepositoryException(e.message));
    }
  }

  @override
  Future<Either<RepositoryException, Nil>> registerAdmin(
      ({String email, String name, String password}) userData) async {
    try {
      await _restClient.unauth.post(
        "/users",
        data: {
          "name": userData.name,
          "email": userData.email,
          "password": userData.password,
          "profile": "ADM",
        },
      );

      return Success(nil);
    } on DioException catch (e, s) {
      log("[ERROR] Erro ao registrar o usuário Admin", error: e, stackTrace: s);
      return Failure(
          RepositoryException("Erro ao realizar o cadastro do usuário Admin"));
    }
  }

  @override
  Future<Either<RepositoryException, List<UserModelEmployee>>> getEmployees(
      int barbershopId) async {
    try {
      var Response(:List data) = await _restClient.auth
          .get('/users', queryParameters: {"barbershop_id": barbershopId});

      final employees = data.map((e) => UserModelEmployee.fromMap(e)).toList();

      return Success(employees);
    } on DioException catch (e, s) {
      log("[ERROR]  Erro ao recuperar lista de colaboradores",
          error: e, stackTrace: s);
      return Failure(
          RepositoryException("Erro ao buscar a lista de colaboradores"));
    } on ArgumentError catch (e, s) {
      log("JSON INVALIDO | Erro ao buscar a lista de colaboradores",
          error: e, stackTrace: s);
      return Failure(
          RepositoryException("Erro ao buscar a lista de colaboradores"));
    }
  }

  @override
  Future<Either<RepositoryException, Nil>> registerAdmAsEmployee(
      ({List<int> workHours, List<String> workDays}) userModel) async {
    try {
      var getMeResult = await me();

      int userId;

      switch (getMeResult) {
        case Success(value: UserModel(:var id)):
          userId = id;
        case Failure(:var exception):
          return Failure(exception);
      }

      await _restClient.auth.put("/users/$userId", data: {
        'work_days': userModel.workDays,
        'work_hours': userModel.workHours,
      });

      return Success(nil);
    } on DioException catch (e, s) {
      log("Erro ao registrar admin como colaborador", error: e, stackTrace: s);
      return Failure(
          RepositoryException("Erro ao registrar admin como colaborador"));
    }
  }

  @override
  Future<Either<RepositoryException, Nil>> registerEmployee(
      ({
        int barbershopId,
        String email,
        String name,
        String password,
        List<String> workDays,
        List<int> workHours
      }) userModel) async {
    try {
      await _restClient.auth.post("/users/", data: {
        'barbershop_id': userModel.barbershopId,
        'name': userModel.name,
        'email': userModel.email,
        'password': userModel.password,
        'profile': 'EMPLOYEE',
        'work_days': userModel.workDays,
        'work_hours': userModel.workHours,
      });

      return Success(nil);
    } on DioException catch (e, s) {
      log("Erro ao registrar colaborador", error: e, stackTrace: s);
      return Failure(RepositoryException("Erro ao registrar colaborador"));
    }
  }
}
