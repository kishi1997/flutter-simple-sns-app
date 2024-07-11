import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiClient {
  final Dio _dio;
  ApiClient({Map<String, String>? headers})
      : _dio = Dio(BaseOptions(
          baseUrl: dotenv.get('API_BASE_URL'),
          headers: headers,
        ));
  Dio get dio => _dio;
}

final apiClient = ApiClient();
