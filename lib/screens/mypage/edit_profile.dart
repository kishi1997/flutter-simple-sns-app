import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_sns_app/components/header/app_header.dart';
import 'package:simple_sns_app/utils/provider_utils.dart';
import 'package:simple_sns_app/utils/validation_utils.dart';
import 'package:simple_sns_app/widgets/form/edit_profile_form.dart';

class EditProfileScreen extends StatefulWidget {
  final String name;
  final String email;

  const EditProfileScreen({super.key, required this.name, required this.email});

  @override
  EditProfileScreenState createState() => EditProfileScreenState();
}

class EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
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
    final currentUser = Provider.of<UserProvider>(context, listen: false).user;

    return Scaffold(
      appBar: AppHeaderWithActions(
          title: 'プロフィール編集',
          buttonText: "保存",
          isFormValid: _isFormValid(),
          onPressed: () async {
            // プロフィール変更処理
          }),
      body: Padding(
        padding: const EdgeInsets.only(
            top: 72.0, left: 24.0, right: 24.0, bottom: 24.0),
        child: EditProfileForm(
          nameController: _nameController,
          emailController: _emailController,
          nameErrorText: _nameErrorText,
          emailErrorText: _emailErrorText,
          currentUserIconUrl: currentUser?.iconImageUrl,
        ),
      ),
    );
  }
}
