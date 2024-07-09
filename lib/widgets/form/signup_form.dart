import 'package:flutter/material.dart';
import 'package:simple_sns_app/components/button/app_button.dart';
import 'package:simple_sns_app/utils/validation_utils.dart';

class SignupForm extends StatefulWidget {
  const SignupForm({super.key});

  @override
  SignupFormState createState() {
    return SignupFormState();
  }
}

class SignupFormState extends State<SignupForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isButtonEnabled = false;
  void _validateForm() {
    setState(() {
      _isButtonEnabled = _formKey.currentState!.validate();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        onChanged: _validateForm,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'アカウント名',
              ),
              validator: (value) {
                return CustomValidators.validateUsername(value);
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'メールアドレス',
              ),
              validator: (value) {
                return CustomValidators.validateEmail(value);
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'パスワード',
              ),
              validator: (value) {
                return CustomValidators.validatePassword(value);
              },
            ),
            const SizedBox(height: 32),
            AppButton(
              text: 'はじめる',
              onPressed: _isButtonEnabled
                  ? () {
                      if (_formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Success')),
                        );
                      }
                    }
                  : null,
              backgroundColor: _isButtonEnabled
                  ? Theme.of(context).primaryColor
                  : Colors.grey,
              textColor: Colors.white,
            ),
          ],
        ));
  }
}
