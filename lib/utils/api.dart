import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:simple_sns_app/utils/token_utils.dart';

class AuthInterceptor extends QueuedInterceptor {
  AuthInterceptor(this.dio);
  final Dio dio;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (options.headers['Authorization']?.isEmpty ?? true) {
      final accessToken = await tokenStorage.getToken();
      options.headers['Authorization'] = 'Bearer $accessToken';
    }
    return handler.next(options);
  }
}

Dio setupDioApiClient() {
  final dio = Dio(BaseOptions(baseUrl: dotenv.get('API_BASE_URL')));
  dio.interceptors.add(AuthInterceptor(dio));
  return dio;
}

final api = setupDioApiClient();
