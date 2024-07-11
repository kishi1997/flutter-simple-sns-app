import 'package:simple_sns_app/domain/account/account_repository.dart';

class AccountService {
  Future<void> signup(String name, String email, String password) async {
    await AccountRepository().signup(name, email, password);
  }
}
