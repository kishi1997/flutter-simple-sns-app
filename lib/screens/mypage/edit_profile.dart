import 'dart:io';

import 'package:flutter/material.dart';
import 'package:simple_sns_app/components/header/app_header.dart';
import 'package:simple_sns_app/domain/account/account_service.dart';
import 'package:simple_sns_app/utils/logger_utils.dart';
import 'package:simple_sns_app/utils/snack_bar_utils.dart';
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
  File? _pickedImage;
  String? _nameErrorText;
  String? _emailErrorText;
  bool _isProcessing = false;

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.name;
    _emailController.text = widget.email;
    _addListeners();
  }

  void _addListeners() {
    void listener() {
      _validateField();
      _isFormUpdated();
    }

    _nameController.addListener(listener);
    _emailController.addListener(listener);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _validateField() {
    setState(() {
      _nameErrorText = CustomValidators.validateUsername(_nameController.text);
      _emailErrorText = CustomValidators.validateEmail(_emailController.text);
    });
  }

  bool _isFormUpdated() {
    return _nameController.text != widget.name ||
        _emailController.text != widget.email ||
        _pickedImage != null;
  }

  bool _isFormValid() {
    return CustomValidators.validateUsername(_nameController.text) == null &&
        CustomValidators.validateEmail(_emailController.text) == null;
  }

  bool _isButtonEnabled() {
    return _isFormValid() && _isFormUpdated() && !_isProcessing;
  }

  Future<void> _updateProfile() async {
    final newName = _nameController.text;
    final newEmail = _emailController.text;

    if (newName != widget.name || newEmail != widget.email) {
      await AccountService().updateProfile(newName, newEmail);
    }

    if (_pickedImage != null) {
      await AccountService().updateIconImage(_pickedImage!);
    }
  }

  Future<void> _handleUpdateProfile(BuildContext context) async {
    setState(() {
      _isProcessing = true;
    });
    try {
      await _updateProfile();
      if (!context.mounted) return;
      showSnackBar(context, "プロフィールを変更しました");
      Navigator.of(context).pop();
    } catch (e) {
      logError(e);
      showSnackBar(context, "プロフィール変更中に一時的なエラーが発生しました、お手数ですが再度お試しください");
    } finally {
      setState(() {
        _isProcessing = false;
      });
    }
  }

  Widget _updateProfileButton(BuildContext context) {
    return TextButton(
      onPressed: () {
        _isButtonEnabled() ? _handleUpdateProfile(context) : null;
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
        decoration: BoxDecoration(
          color: _isButtonEnabled()
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

  void _showPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return IconImagePicker(
          onImagePicked: (File? image) {
            setState(() {
              _pickedImage = image;
            });
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppHeader(
            title: 'プロフィール編集', actions: [_updateProfileButton(context)]),
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
                      imageFile: _pickedImage,
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
