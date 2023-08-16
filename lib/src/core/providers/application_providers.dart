import 'package:barber_app/src/core/rest/rest_client.dart';
import 'package:barber_app/src/repositories/user/user_repository.dart';
import 'package:barber_app/src/repositories/user/user_repository_impl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'application_providers.g.dart';

@Riverpod(keepAlive: true)
RestClient restClient(RestClientRef ref) => RestClient();

@Riverpod(keepAlive: true)
UserRepository userRepository(UserRepositoryRef ref) =>
    UserRepositoryImpl(ref.read(restClientProvider));
