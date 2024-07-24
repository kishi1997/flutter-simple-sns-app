import 'package:flutter/material.dart';

class CustomValidators {
  static String? validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'ユーザー名を入力してください';
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'メールアドレスを入力してください';
    }
    String pattern = r'^[a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return '有効なメールアドレスを入力してください';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'パスワードを入力してください';
    }
    if (value.length < 8) {
      return 'パスワードは8文字以上で入力してください';
    }
    return null;
  }

  static String? validatePostCreationForm(String? value) {
    if (value == null || value.trim().isEmpty) {
      return '投稿は1文字以上で入力してください';
    }
    return null;
  }

  static String? validateEmpty(String? value) {
    if (value == null || value.trim().isEmpty) {
      return '1文字以上で入力してください';
    }
    return null;
  }
}

bool isFormFieldValid(String? errorText, TextEditingController controller) {
  return errorText == null && controller.text.isNotEmpty;
}
