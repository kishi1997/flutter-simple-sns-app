import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:simple_sns_app/domain/account/account_service.dart';
import 'package:simple_sns_app/domain/user/user_entity.dart';
import 'package:simple_sns_app/screens/post/post_list_screen.dart';
import 'screens/onboarding_screen.dart';

Future<void> main() async {
  await dotenv.load(fileName: '.env');
  final user = await AccountService().getAccount();
  runApp(MyApp(user: user));
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
