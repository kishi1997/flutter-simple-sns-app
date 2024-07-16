import 'package:flutter/material.dart';
import 'package:simple_sns_app/components/button/app_button.dart';
import 'package:simple_sns_app/domain/auth/auth_service.dart';
import 'package:simple_sns_app/screens/post/post_list_screen.dart';
import 'package:simple_sns_app/screens/signup_screen.dart';
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

  String? _emailErrorText;
  String? _passwordErrorText;

  bool _isValidEmail = false;
  bool _isValidPassword = false;
  bool _isFormValid = false;

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

  void _validateField(String field) {
    setState(() {
      if (field == 'email') {
        _emailErrorText = CustomValidators.validateEmail(_emailController.text);
        _isValidEmail = isFormFieldValid(_emailErrorText, _emailController);
      } else if (field == 'password') {
        _passwordErrorText =
            CustomValidators.validatePassword(_passwordController.text);
        _isValidPassword =
            isFormFieldValid(_passwordErrorText, _passwordController);
      }
    });
    _isFormValid = _isValidEmail && _isValidPassword;
  }

  Future<void> _signIn() async {
    final email = _emailController.text;
    final password = _passwordController.text;
    try {
      await AuthService().signin(email, password);
      if (!mounted) return;
      showSnackBar(context, 'サインインに成功しました！');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const PostListScreen()),
      );
    } catch (e) {
      logger.e(e);
      showSnackBar(context, "サインインに失敗しました");
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
          onPressed: _isFormValid
              ? () async {
                  await _signIn();
                }
              : null,
          backgroundColor:
              _isFormValid ? Theme.of(context).primaryColor : Colors.grey,
          textColor: Colors.white,
        ),
      ],
    ));
  }
}
