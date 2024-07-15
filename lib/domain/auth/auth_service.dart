import 'package:simple_sns_app/domain/account/account_entity.dart';
import 'package:simple_sns_app/domain/auth/auth_repository.dart';
import 'package:simple_sns_app/utils/token_utils.dart';

class AuthService {
  Future<Account> signin(String email, String password) async {
    final accountData = await AuthRepository().signin(email, password);
    await tokenStorage.saveToken(accountData.token);
    return accountData;
  }
}
