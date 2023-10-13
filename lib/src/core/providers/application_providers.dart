import 'package:barber_app/src/core/fp/either.dart';
import 'package:barber_app/src/core/rest/rest_client.dart';
import 'package:barber_app/src/models/user_model.dart';
import 'package:barber_app/src/repositories/barbershop/barbershop_repository.dart';
import 'package:barber_app/src/repositories/barbershop/barbershop_repository_impl.dart';
import 'package:barber_app/src/repositories/user/user_repository.dart';
import 'package:barber_app/src/repositories/user/user_repository_impl.dart';
import 'package:barber_app/src/services/user_login/user_login_service_impl.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/barbershop_model.dart';
import '../../services/user_login/user_login_service.dart';
import '../ui/barbershop_nav_global_key.dart';

part 'application_providers.g.dart';

@Riverpod(keepAlive: true)
RestClient restClient(RestClientRef ref) => RestClient();

@Riverpod(keepAlive: true)
UserRepository userRepository(UserRepositoryRef ref) =>
    UserRepositoryImpl(ref.read(restClientProvider));

@Riverpod(keepAlive: true)
UserLoginService userLoginService(UserLoginServiceRef ref) =>
    UserLoginServiceImpl(repo: ref.read(userRepositoryProvider));

@Riverpod(keepAlive: true)
Future<UserModel> getMe(GetMeRef ref) async {
  final result = await ref.watch(userRepositoryProvider).me();

  return switch (result) {
    Success(value: final userModel) => userModel,
    Failure(exception: final exception) => throw exception,
  };
}

@Riverpod(keepAlive: true)
BarbershopRepository barbershopRepository(BarbershopRepositoryRef ref) =>
    BarbershopRepositoryImpl(ref.read(restClientProvider));

@Riverpod(keepAlive: true)
Future<BarbershopModel> getMyBarbershop(GetMyBarbershopRef ref) async {
  final userModel = await ref.watch(getMeProvider.future);

  final barbershopRepository = ref.read(barbershopRepositoryProvider);

  final result = await barbershopRepository.getMyBarbershop(userModel);

  return switch (result) {
    Success(value: final barbershop) => barbershop,
    Failure(exception: final exception) => throw exception,
  };
}

@Riverpod()
Future<void> logout(LogoutRef ref) async {
  final sp = await SharedPreferences.getInstance();

  sp.clear();

  ref.invalidate(getMeProvider);
  ref.invalidate(getMyBarbershopProvider);

  Navigator.of(BarbershopNavGlobalKey.instance.key.currentContext!)
      .pushNamedAndRemoveUntil("/auth/login", (route) => false);
}
