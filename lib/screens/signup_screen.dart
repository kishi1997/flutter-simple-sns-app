import 'package:flutter/material.dart';
import 'package:simple_sns_app/components/header/app_header.dart';
import 'package:simple_sns_app/widgets/form/signup_form.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: AppHeader(title: 'アカウント作成'),
      body: Padding(
        padding: EdgeInsets.all(24.0),
        child: SignupForm(),
      ),
    );
  }
}
