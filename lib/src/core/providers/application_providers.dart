import 'package:barber_app/src/core/fp/either.dart';
import 'package:barber_app/src/core/rest/rest_client.dart';
import 'package:barber_app/src/models/user_model.dart';
import 'package:barber_app/src/repositories/user/user_repository.dart';
import 'package:barber_app/src/repositories/user/user_repository_impl.dart';
import 'package:barber_app/src/services/user_login/user_login_service_impl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../services/user_login/user_login_service.dart';

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
