import 'package:flutter/material.dart';
import 'package:simple_sns_app/domain/post/post_service.dart';
import 'package:simple_sns_app/utils/logger_utils.dart';
import 'package:simple_sns_app/utils/snack_bar_utils.dart';
import 'package:simple_sns_app/components/header/app_header.dart';
import 'package:simple_sns_app/utils/validation_utils.dart';

class PostCreationScreen extends StatefulWidget {
  const PostCreationScreen({super.key});

  @override
  PostCreationScreenState createState() => PostCreationScreenState();
}

class PostCreationScreenState extends State<PostCreationScreen> {
  final TextEditingController _postFormController = TextEditingController();
  int _charCount = 0;
  static const int _MAX_POST_LENGTH = 140;
  String? _postFormErrorText;
  bool _isProcessing = false;

  @override
  void initState() {
    super.initState();
    _postFormController.addListener(() {
      _updateCharCount();
      _validateField();
    });
  }

  @override
  void dispose() {
    _postFormController.dispose();
    super.dispose();
  }

  bool _isFormValid() {
    return CustomValidators.validatePostCreationForm(
            _postFormController.text) ==
        null;
  }

  bool _isButtonEnabled() {
    return _isFormValid() && !_isProcessing;
  }

  void _updateCharCount() {
    setState(() {
      _charCount = _postFormController.text.length;
    });
  }

  void _validateField() {
    setState(() {
      _postFormErrorText =
          CustomValidators.validatePostCreationForm(_postFormController.text);
    });
  }

  Future<void> _createPost() async {
    _isProcessing = true;
    try {
      final newPost = await PostService().createPost(_postFormController.text);
      if (!mounted) return;
      showSnackBar(context, '投稿が完了しました！');
      Navigator.of(context).pop(newPost);
    } catch (e) {
      logError(e);
      showSnackBar(context, '一時的なエラーが発生しました。再度お試しください。');
    } finally {
      _isProcessing = false;
    }
  }

  Widget _postButton() {
    return TextButton(
      onPressed: _isButtonEnabled() ? _createPost : null,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
        decoration: BoxDecoration(
          color: _isButtonEnabled()
              ? Colors.white
              : const Color.fromARGB(108, 255, 255, 255),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: const Text(
          "投稿",
          style: TextStyle(color: Colors.lightGreen, fontSize: 16.0),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppHeader(
        title: '投稿作成',
        actions: [
          _postButton(),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            TextField(
              controller: _postFormController,
              maxLines: null,
              maxLength: _MAX_POST_LENGTH,
              decoration: InputDecoration(
                hintText: '投稿内容を記入...',
                border: InputBorder.none,
                errorText: _postFormErrorText,
                // 文字数カウンターは自前で用意したものを使いたいため、デフォルトの文字カウンターは非表示
                counterText: '',
              ),
            ),
            const Spacer(),
            Align(
              alignment: Alignment.bottomRight,
              child: Text(
                '$_charCount / $_MAX_POST_LENGTH',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
