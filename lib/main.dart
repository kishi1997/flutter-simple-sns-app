import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_sns_app/domain/account/account_service.dart';
import 'package:simple_sns_app/domain/user/user_entity.dart';
import 'package:simple_sns_app/screens/home_screen.dart';
import 'package:simple_sns_app/utils/provider_utils.dart';
import 'package:simple_sns_app/utils/load_utils.dart';
import 'package:simple_sns_app/utils/logger_utils.dart';
import 'screens/onboarding_screen.dart';

Future<void> main() async {
  await loadEnvironmentVariables();
  await _initializeUser();
  runApp(
    ChangeNotifierProvider(
      create: (context) => userProvider,
      child: const MyApp(),
    ),
  );
}

Future<void> _initializeUser() async {
  try {
    User? user = await AccountService().getAccount();
    if (user != null) {
      userProvider.setUser(user);
    }
  } catch (e) {
    logError(e);
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SIMPLE SNS APP',
      theme: ThemeData(
        primaryColor: Colors.lightGreen,
        useMaterial3: true,
      ),
      home: Consumer<UserProvider>(
        builder: (context, userProvider, child) {
          return userProvider.user != null
              ? const HomeScreen()
              : const OnboardingScreen();
        },
      ),
    );
  }
}
