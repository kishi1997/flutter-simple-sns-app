import 'package:flutter/material.dart';
import 'package:simple_sns_app/components/header/app_header.dart';
import 'package:simple_sns_app/utils/validation_utils.dart';
import 'package:simple_sns_app/widgets/user/uset_icon.dart';

class EditProfileScreen extends StatefulWidget {
  final String name;
  final String email;
  final String iconUrl;

  const EditProfileScreen(
      {super.key,
      required this.name,
      required this.email,
      required this.iconUrl});

  @override
  EditProfileScreenState createState() => EditProfileScreenState();
}

class EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _iconUrlController = TextEditingController();

  String? _nameErrorText;
  String? _emailErrorText;

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.name;
    _emailController.text = widget.email;
    _iconUrlController.text = widget.iconUrl;
    _nameController.addListener(() => _validateField('name'));
    _emailController.addListener(() => _validateField('email'));
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  bool _isFormValid() {
    return CustomValidators.validateUsername(_nameController.text) == null &&
        CustomValidators.validateEmail(_emailController.text) == null;
  }

  // 仮のプロフィール変更処理
  void _updateProfile() {}

  Widget _updateProfileButton() {
    return TextButton(
      onPressed: () async {
        _isFormValid() ? _updateProfile : null;
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
        decoration: BoxDecoration(
          color: _isFormValid()
              ? Colors.white
              : const Color.fromARGB(108, 255, 255, 255),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: const Text(
          "保存",
          style: TextStyle(color: Colors.lightGreen, fontSize: 16.0),
        ),
      ),
    );
  }

  void _validateField(String field) {
    setState(() {
      if (field == 'name') {
        _nameErrorText =
            CustomValidators.validateUsername(_nameController.text);
      } else if (field == 'email') {
        _emailErrorText = CustomValidators.validateEmail(_emailController.text);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppHeader(title: 'プロフィール編集', actions: [_updateProfileButton()]),
        body: Center(
            child: SingleChildScrollView(
                padding: const EdgeInsets.only(
                    top: 72.0, left: 24.0, right: 24.0, bottom: 24.0),
                child: Column(
                  children: [
                    ConstrainedBox(
                      constraints: const BoxConstraints(
                        maxHeight: 70,
                      ),
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: UserIcon(iconImageUrl: _iconUrlController.text),
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
                      controller: _nameController,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: 'アカウント名',
                        errorText: _nameErrorText,
                      ),
                    ),
                    const SizedBox(height: 40),
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: 'メールアドレス',
                        errorText: _emailErrorText,
                      ),
                    ),
                  ],
                ))));
  }
}
