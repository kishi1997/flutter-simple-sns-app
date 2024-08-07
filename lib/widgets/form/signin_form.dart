import 'package:flutter/material.dart';
import 'package:simple_sns_app/components/button/app_button.dart';
import 'package:simple_sns_app/domain/auth/auth_service.dart';
import 'package:simple_sns_app/screens/home_screen.dart';
import 'package:simple_sns_app/utils/logger_utils.dart';
import 'package:simple_sns_app/utils/snack_bar_utils.dart';
import 'package:simple_sns_app/utils/validation_utils.dart';

class SigninForm extends StatefulWidget {
  const SigninForm({super.key});
  @override
  SigninFormState createState() => SigninFormState();
}

class SigninFormState extends State<SigninForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isProcessing = false;

  String? _emailErrorText;
  String? _passwordErrorText;
  @override
  void initState() {
    super.initState();
    _emailController.addListener(() => _validateField('email'));
    _passwordController.addListener(() => _validateField('password'));
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  bool _isFormValid() {
    return CustomValidators.validateEmail(_emailController.text) == null &&
        CustomValidators.validatePassword(_passwordController.text) == null;
  }

  void _validateField(String field) {
    setState(() {
      if (field == 'email') {
        _emailErrorText = CustomValidators.validateEmail(_emailController.text);
      } else if (field == 'password') {
        _passwordErrorText =
            CustomValidators.validatePassword(_passwordController.text);
      }
    });
  }

  bool _isButtonEnabled() {
    return _isFormValid() && !_isProcessing;
  }

  Future<void> _signIn() async {
    setState(() {
      _isProcessing = true;
    });
    final email = _emailController.text;
    final password = _passwordController.text;
    try {
      await AuthService().signin(email, password);
      if (!mounted) return;
      showSuccessSnackBar(context, 'サインインに成功しました！');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } catch (e) {
      logError(e);
      showFailureSnackBar(context, "サインインに失敗しました");
    } finally {
      setState(() {
        _isProcessing = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextFormField(
          controller: _emailController,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: 'メールアドレス',
            errorText: _emailErrorText,
          ),
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _passwordController,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: 'パスワード',
            errorText: _passwordErrorText,
          ),
        ),
        const SizedBox(height: 32),
        AppButton(
          text: 'ログインする',
          onPressed: _isButtonEnabled() ? _signIn : null,
          backgroundColor:
              _isButtonEnabled() ? Theme.of(context).primaryColor : Colors.grey,
          textColor: Colors.white,
        ),
      ],
    ));
  }
}
