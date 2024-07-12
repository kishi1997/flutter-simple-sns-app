import 'package:simple_sns_app/domain/account/account_entity.dart';
import 'package:simple_sns_app/utils/api.dart';

class AccountRepository {
  Future<Account> signup(String name, String email, String password) async {
    try {
      final res = await apiClient.dio.post(
        '/account',
        data: {'name': name, 'email': email, 'password': password},
      );
      return Account.fromJson(res.data);
    } catch (e) {
      throw Exception('Failed to signup: $e');
    }
  }
}
