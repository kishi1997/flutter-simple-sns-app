import 'package:flutter/material.dart';
import 'package:simple_sns_app/domain/account/account_service.dart';
import 'package:simple_sns_app/domain/user/user_entity.dart';
import 'package:simple_sns_app/screens/post/post_list_screen.dart';
import 'package:simple_sns_app/utils/load_utils.dart';
import 'package:simple_sns_app/utils/logger_utils.dart';
import 'screens/onboarding_screen.dart';

Future<void> main() async {
  await loadEnvironmentVariables();
  User? user = await _initializeUser();
  runApp(MyApp(user: user));
}

Future<User?> _initializeUser() async {
  try {
    return await AccountService().getAccount();
  } catch (e) {
    logError(e);
    return null;
  }
}

class MyApp extends StatelessWidget {
  final User? user;
  const MyApp({super.key, required this.user});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SIMPLE SNS APP',
      theme: ThemeData(
        primaryColor: Colors.lightGreen,
        useMaterial3: true,
      ),
      home: user != null ? const PostListScreen() : const OnboardingScreen(),
    );
  }
}
