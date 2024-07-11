import 'package:simple_sns_app/domain/account/account_repository.dart';

class AccountService {
  final AccountRepository _accountRepository;
  AccountService(this._accountRepository);
  Future<void> signup(String name, String email, String password) async {
    await _accountRepository.signup(name, email, password);
  }
}
