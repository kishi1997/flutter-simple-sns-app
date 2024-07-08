import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:simple_sns_app/components/header/app_header.dart';
import 'package:simple_sns_app/widgets/form/signup_form.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppHeader(title: 'アカウント作成'),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SignupForm(),
            const SizedBox(height: 16),
            RichText(
              text: TextSpan(
                text: 'ログインはこちら',
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                  decoration: TextDecoration.underline,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    // ログインページに遷移する処理
                  },
              ),
            ),
            const SizedBox(height: 16),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: 'はじめることにより、',
                style: const TextStyle(fontSize: 12, color: Colors.grey),
                children: [
                  TextSpan(
                    text: '利用規約',
                    style: const TextStyle(
                      decoration: TextDecoration.underline,
                      color: Colors.blue,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        // リンクを貼って遷移する処理
                      },
                  ),
                  const TextSpan(
                    text: 'と',
                    style: TextStyle(color: Colors.grey),
                  ),
                  TextSpan(
                    text: 'プライバシーポリシー',
                    style: const TextStyle(
                      decoration: TextDecoration.underline,
                      color: Colors.blue,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        // リンクを貼って遷移する処理
                      },
                  ),
                  const TextSpan(
                    text: 'に同意したものとみなします',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
