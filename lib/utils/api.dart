import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final api = Dio(BaseOptions(baseUrl: dotenv.get('API_BASE_URL')));
