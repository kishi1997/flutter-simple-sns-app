import 'package:simple_sns_app/domain/account/account_entity.dart';
import 'package:simple_sns_app/domain/account/account_repository.dart';

class AccountService {
  Future<Account> signup(String name, String email, String password) async {
    final accountData = await AccountRepository().signup(name, email, password);
    return accountData;
  }
}
