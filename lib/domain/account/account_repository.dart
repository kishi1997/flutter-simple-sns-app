// import 'dart:io';

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:simple_sns_app/domain/account/account_entity.dart';
import 'package:simple_sns_app/domain/user/user_entity.dart';
import 'package:simple_sns_app/utils/api.dart';

class AccountRepository {
  Future<Account> signup(String name, String email, String password) async {
    try {
      final res = await api.post(
        '/account',
        data: {'name': name, 'email': email, 'password': password},
      );
      return Account.fromJson(res.data);
    } catch (e) {
      throw Exception('Failed to signup: $e');
    }
  }

  Future<User?> getAccount() async {
    try {
      final res = await api.get(
        '/account',
      );
      if (res.data["user"] == null) {
        return null;
      }
      return User.fromJson(res.data["user"]);
    } catch (e) {
      throw Exception('Failed to get account: $e');
    }
  }

  Future<User> updateProfile(String name, String email) async {
    try {
      final res = await api.patch(
        '/account/profile',
        data: {'name': name, 'email': email},
      );
      return User.fromJson(res.data["user"]);
    } catch (e) {
      throw Exception('Failed to update profile: $e');
    }
  }

  Future<User> updateIconImage(File file) async {
    try {
      final fileName = file.path.split('/').last;
      final formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(file.path, filename: fileName),
      });
      final res = await api.patch(
        '/account/icon_image',
        data: formData,
      );
      return User.fromJson(res.data["user"]);
    } catch (e) {
      throw Exception('Failed to update iconImage: $e');
    }
  }
}
