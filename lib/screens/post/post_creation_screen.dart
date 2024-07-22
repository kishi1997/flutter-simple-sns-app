import 'package:flutter/material.dart';
import 'package:simple_sns_app/domain/post/post_service.dart';
import 'package:simple_sns_app/utils/logger_utils.dart';
import 'package:simple_sns_app/utils/snack_bar_utils.dart';
import 'package:simple_sns_app/utils/validation_utils.dart';

class PostCreationScreen extends StatefulWidget {
  const PostCreationScreen({super.key});
  @override
  PostCreationScreenState createState() => PostCreationScreenState();
}

class PostCreationScreenState extends State<PostCreationScreen> {
  final TextEditingController _postFormController = TextEditingController();
  int _charCount = 0;
  final int _MAX_POST_LENGTH = 140;
  String? _postFormErrorText;

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

  Future<void> _createPost(String content) async {
    try {
      final newPost = await PostService().createPost(content);
      if (!mounted) return;
      showSnackBar(context, '投稿が完了しました！');
      Navigator.of(context).pop(newPost);
    } catch (e) {
      logError(e);
      showSnackBar(context, '一時的なエラーが発生しました。再度お試しください。');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('投稿作成'),
        actions: [
          TextButton(
            onPressed: _isFormValid()
                ? () {
                    _createPost();
                  }
                : null,
            child: Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
              decoration: BoxDecoration(
                color: _isFormValid()
                    ? Theme.of(context).primaryColor
                    : Colors.grey,
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: const Text(
                '投稿',
                style: TextStyle(color: Colors.white, fontSize: (16.0)),
              ),
            ),
          ),
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
