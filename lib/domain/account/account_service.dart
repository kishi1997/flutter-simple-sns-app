import 'package:simple_sns_app/domain/account/account_entity.dart';
import 'package:simple_sns_app/domain/account/account_repository.dart';
import 'package:simple_sns_app/domain/user/user_entity.dart';
import 'package:simple_sns_app/utils/token_utils.dart';

class AccountService {
  Future<Account> signup(String name, String email, String password) async {
    final accountData = await AccountRepository().signup(name, email, password);
    await tokenStorage.saveToken(accountData.token);
    return accountData;
  }

  Future<User?> getAccount() async {
    final accountData = await AccountRepository().getAccount();
    return accountData;
  }
}
