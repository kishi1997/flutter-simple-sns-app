import 'dart:io';

import 'package:flutter/material.dart';
import 'package:simple_sns_app/components/header/app_header.dart';
import 'package:simple_sns_app/utils/validation_utils.dart';
import 'package:simple_sns_app/widgets/mypage/icon_image_picker.dart';
import 'package:simple_sns_app/widgets/mypage/profile_icon.dart';

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
  File? _image;
  String? _nameErrorText;
  String? _emailErrorText;

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.name;
    _emailController.text = widget.email;
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

  // 仮のプロフィール変更の非同期処理
  Future<void> _updateProfile() async {}

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

  void _showPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return IconImagePicker(
          initialImage: _image,
          onImagePicked: (File? image) {
            setState(() {
              _image = image;
            });
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppHeader(title: 'プロフィール編集', actions: [_updateProfileButton()]),
        body: Padding(
            padding: const EdgeInsets.only(
                top: 72.0, left: 24.0, right: 24.0, bottom: 24.0),
            child: Column(
              children: [
                ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxHeight: 80,
                    ),
                    child: ProfileIcon(
                      iconImageUrl: widget.iconUrl,
                      imageFile: _image,
                    )),
                const SizedBox(height: 16),
                GestureDetector(
                    onTap: () {
                      _showPicker(context);
                    },
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
            )));
  }
}
