import 'package:dio/dio.dart';
import 'package:simple_sns_app/utils/api.dart';

class AccountRepository {
  Future<Response> signup(String name, String email, String password) async {
    try {
      final response = await apiClient.dio.post(
        '/account',
        data: {'name': name, 'email': email, 'password': password},
      );
      return response;
    } catch (e) {
      throw Exception('Failed to signup: $e');
    }
  }
}
