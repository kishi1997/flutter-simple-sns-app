// import 'dart:io';

import 'dart:io';

import 'package:simple_sns_app/domain/account/account_entity.dart';
import 'package:simple_sns_app/domain/account/account_repository.dart';
import 'package:simple_sns_app/domain/user/user_entity.dart';
import 'package:simple_sns_app/utils/provider_utils.dart';
import 'package:simple_sns_app/utils/token_utils.dart';

class AccountService {
  Future<Account> signup(String name, String email, String password) async {
    final accountData = await AccountRepository().signup(name, email, password);
    await tokenStorage.saveToken(accountData.token);
    userProvider.setUser(accountData.user);
    return accountData;
  }

  Future<User?> getAccount() async {
    final accountData = await AccountRepository().getAccount();
    return accountData;
  }

  Future<User> updateProfile(String name, String email) async {
    final updatedAccountData =
        await AccountRepository().updateProfile(name, email);
    userProvider.setUser(updatedAccountData);
    return updatedAccountData;
  }

  Future<User> updateIconImage(File file) async {
    final updatedAccountData = await AccountRepository().updateIconImage(file);
    userProvider.setUser(updatedAccountData);
    return updatedAccountData;
  }
}
