import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:logger/web.dart';
import 'package:simple_sns_app/components/header/app_header.dart';
import 'package:simple_sns_app/screens/signup_screen.dart';
import 'package:simple_sns_app/utils/navigation_utils.dart';
import 'package:simple_sns_app/widgets/form/signin_form.dart';

var logger = Logger();

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppHeader(title: 'サインイン'),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SigninForm(),
            const SizedBox(height: 16),
            RichText(
              text: TextSpan(
                text: 'アカウントをお持ちでない方はこちら',
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                  decoration: TextDecoration.underline,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    navigateToPageReplacement(context, const SignUpScreen());
                  },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
