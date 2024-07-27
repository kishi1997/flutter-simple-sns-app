import 'package:flutter/material.dart';
import 'package:simple_sns_app/components/button/app_button.dart';
import 'package:simple_sns_app/domain/account/account_service.dart';
import 'package:simple_sns_app/screens/home_screen.dart';
import 'package:simple_sns_app/utils/logger_utils.dart';
import 'package:simple_sns_app/utils/snack_bar_utils.dart';
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
  bool _isProcessing = false;

  String? _nameErrorText;
  String? _emailErrorText;
  String? _passwordErrorText;

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
      } else if (field == 'email') {
        _emailErrorText = CustomValidators.validateEmail(_emailController.text);
      } else if (field == 'password') {
        _passwordErrorText =
            CustomValidators.validatePassword(_passwordController.text);
      }
    });
  }

  bool _isFormValid() {
    return CustomValidators.validateUsername(_nameController.text) == null &&
        CustomValidators.validateEmail(_emailController.text) == null &&
        CustomValidators.validatePassword(_passwordController.text) == null;
  }

  bool _isButtonEnabled() {
    return _isFormValid() && !_isProcessing;
  }

  Future<void> _signup() async {
    setState(() {
      _isProcessing = true;
    });
    final name = _nameController.text;
    final email = _emailController.text;
    final password = _passwordController.text;

    try {
      await AccountService().signup(name, email, password);
      if (!mounted) return;
      showSnackBar(context, 'アカウントが登録されました');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } catch (e) {
      logError(e);
      showSnackBar(context, "アカウントの登録に失敗しました");
    } finally {
      setState(() {
        _isProcessing = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    logger.d(_isButtonEnabled());
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
          onPressed: _isButtonEnabled() ? _signup : null,
          backgroundColor:
              _isButtonEnabled() ? Theme.of(context).primaryColor : Colors.grey,
          textColor: Colors.white,
        ),
      ],
    ));
  }
}
