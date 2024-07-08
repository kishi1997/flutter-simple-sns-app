import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:simple_sns_app/components/button/app_button.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('アカウント作成', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
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
                        }),
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
