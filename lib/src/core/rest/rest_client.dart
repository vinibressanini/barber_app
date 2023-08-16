import 'package:dio/dio.dart';
import 'package:dio/io.dart';

class RestClient extends DioForNative {
  RestClient()
      : super(
          BaseOptions(
            baseUrl: "192.168.0.4:8080",
            connectTimeout: const Duration(seconds: 10),
            receiveTimeout: const Duration(minutes: 1),
          ),
        ) {
    interceptors.addAll([
      LogInterceptor(
        requestBody: true,
        responseBody: true,
      )
    ]);
  }

  RestClient get auth {
    options.extra["DIO_AUTH_KEY"] = true;
    return this;
  }

  RestClient get unauth {
    options.extra["DIO_AUTH_KEY"] = false;
    return this;
  }
}
