import 'package:simple_sns_app/domain/account/account_entity.dart';
import 'package:simple_sns_app/utils/api.dart';

class AuthRepository {
  Future<Account> signin(String email, String password) async {
    try {
      final res = await api.post(
        '/auth',
        data: {'email': email, 'password': password},
      );
      return Account.fromJson(res.data);
    } catch (e) {
      throw Exception('Failed to signin: $e');
    }
  }
}
