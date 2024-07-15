import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:simple_sns_app/screens/signin_screen.dart';
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
      logger.d(accessToken);
      options.headers['Authorization'] = 'Bearer $accessToken';
    }
    return handler.next(options);
  }
}

class ApiClient {
  final Dio _dio;

  ApiClient({Map<String, String>? headers})
      : _dio = Dio(BaseOptions(
          baseUrl: dotenv.get('API_BASE_URL'),
          headers: headers,
        )) {
    _dio.interceptors.add(AuthInterceptor(_dio));
  }
  Dio get dio => _dio;
}

final apiClient = ApiClient();
