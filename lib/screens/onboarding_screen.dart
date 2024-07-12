import 'package:flutter/material.dart';
import 'package:simple_sns_app/screens/signin_screen.dart';
import 'package:simple_sns_app/utils/navigation_utils.dart';
import '../components/button/app_button.dart';
import './signup_screen.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'images/logo.png',
                height: 100,
              ),
              const SizedBox(height: 10),
              const Text(
                'Simple SNS',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  children: [
                    AppButton(
                      text: 'はじめる',
                      onPressed: () {
                        navigateToPageReplacement(
                            context, const SignUpScreen());
                      },
                      backgroundColor: Theme.of(context).primaryColor,
                      textColor: Colors.white,
                    ),
                    const SizedBox(height: 20),
                    AppButton(
                      text: 'ログイン',
                      onPressed: () {
                        navigateToPageReplacement(
                            context, const SignInScreen());
                      },
                      backgroundColor: Colors.white,
                      textColor: Colors.black,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
