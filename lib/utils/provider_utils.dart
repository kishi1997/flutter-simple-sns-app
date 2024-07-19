import 'package:flutter/material.dart';
import 'package:simple_sns_app/domain/user/user_entity.dart';

class UserProvider extends ChangeNotifier {
  User? _user;

  User? get user => _user;

  void setUser(User? newUser) {
    _user = newUser;
    notifyListeners();
  }
}

UserProvider userProvider = UserProvider();
