import 'package:flutter/material.dart';
import 'package:simple_sns_app/components/button/app_button.dart';
import 'package:simple_sns_app/utils/link_utils.dart';

class SignupForm extends StatelessWidget {
  const SignupForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'アカウント名',
          ),
        ),
        const SizedBox(height: 16),
        const TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'メールアドレス',
          ),
        ),
        const SizedBox(height: 16),
        const TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'パスワード',
          ),
          obscureText: true,
        ),
        const SizedBox(height: 32),
        AppButton(
          text: 'はじめる',
          onPressed: () {
            // はじめるボタンの処理
          },
          backgroundColor: Theme.of(context).primaryColor,
          textColor: Colors.white,
        ),
      ],
    );
  }
}
