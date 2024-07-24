import 'package:flutter/material.dart';
import 'package:simple_sns_app/widgets/user/uset_icon.dart';

class EditProfileForm extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final String? nameErrorText;
  final String? emailErrorText;
  final String? currentUserIconUrl;

  const EditProfileForm({
    super.key,
    required this.nameController,
    required this.emailController,
    this.nameErrorText,
    this.emailErrorText,
    this.currentUserIconUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ConstrainedBox(
          constraints: const BoxConstraints(
            maxHeight: 70,
          ),
          child: AspectRatio(
            aspectRatio: 1,
            child: userIcon(currentUserIconUrl),
          ),
        ),
        const SizedBox(height: 16),
        GestureDetector(
            // onTap: 画像変更処理,
            child: const Text(
          'アイコン画像を変更',
          style: TextStyle(
            decoration: TextDecoration.underline,
          ),
        )),
        const SizedBox(height: 32),
        TextFormField(
          controller: nameController,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: 'アカウント名',
            errorText: nameErrorText,
          ),
        ),
        const SizedBox(height: 40),
        TextFormField(
          controller: emailController,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: 'メールアドレス',
            errorText: emailErrorText,
          ),
        ),
      ],
    );
  }
}
