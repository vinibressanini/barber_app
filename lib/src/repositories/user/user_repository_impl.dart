import 'dart:developer';
import 'dart:io';

import 'package:barber_app/src/core/exceptions/auth_exception.dart';
import 'package:barber_app/src/core/exceptions/repository_exception.dart';
import 'package:barber_app/src/core/fp/either.dart';
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
}
