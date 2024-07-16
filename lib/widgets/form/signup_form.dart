import 'package:flutter/material.dart';
import 'package:simple_sns_app/components/button/app_button.dart';
import 'package:simple_sns_app/domain/account/account_service.dart';
import 'package:simple_sns_app/utils/logger_utils.dart';
import 'package:simple_sns_app/utils/validation_utils.dart';

class SignupForm extends StatefulWidget {
  const SignupForm({super.key});

  @override
  SignupFormState createState() => SignupFormState();
}

class SignupFormState extends State<SignupForm> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String? _nameErrorText;
  String? _emailErrorText;
  String? _passwordErrorText;

  bool _isValidName = false;
  bool _isValidEmail = false;
  bool _isValidPassword = false;
  bool _isFormValid = false;

  @override
  void initState() {
    super.initState();
    _nameController.addListener(() => _validateField('name'));
    _emailController.addListener(() => _validateField('email'));
    _passwordController.addListener(() => _validateField('password'));
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _validateField(String field) {
    setState(() {
      if (field == 'name') {
        _nameErrorText =
            CustomValidators.validateUsername(_nameController.text);
        _isValidName = isFormFieldValid(_nameErrorText, _nameController);
      } else if (field == 'email') {
        _emailErrorText = CustomValidators.validateEmail(_emailController.text);
        _isValidEmail = isFormFieldValid(_emailErrorText, _emailController);
      } else if (field == 'password') {
        _passwordErrorText =
            CustomValidators.validatePassword(_passwordController.text);
        _isValidPassword =
            isFormFieldValid(_passwordErrorText, _passwordController);
      }
    });
    _isFormValid = _isValidName && _isValidEmail && _isValidPassword;
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Future<void> _signup() async {
    final name = _nameController.text;
    final email = _emailController.text;
    final password = _passwordController.text;

    try {
      await AccountService().signup(name, email, password);
      _showSnackBar('アカウントが登録されました');
    } catch (e) {
      logError(e);
      _showSnackBar("アカウントの登録に失敗しました");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextFormField(
          controller: _nameController,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: 'アカウント名',
            errorText: _nameErrorText,
          ),
        ),
        const SizedBox(height: 16),
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
          text: 'はじめる',
          onPressed: _isFormValid
              ? () {
                  _signup();
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
