import 'package:flutter/material.dart';
import 'package:simple_sns_app/domain/message/message_service.dart';
import 'package:simple_sns_app/utils/logger_utils.dart';
import 'package:simple_sns_app/utils/snack_bar_utils.dart';
import 'package:simple_sns_app/components/header/app_header.dart';
import 'package:simple_sns_app/utils/validation_utils.dart';

class PostReplyScreen extends StatefulWidget {
  final int postId;
  const PostReplyScreen({super.key, required this.postId});

  @override
  PostReplyScreenState createState() => PostReplyScreenState();
}

class PostReplyScreenState extends State<PostReplyScreen> {
  final TextEditingController _replyFormController = TextEditingController();
  int _charCount = 0;
  static const int _MAX_POST_LENGTH = 140;
  String? _replyFormErrorText;
  bool _isProcessing = false;

  @override
  void initState() {
    super.initState();
    _replyFormController.addListener(() {
      _updateCharCount();
      _validateField();
    });
  }

  @override
  void dispose() {
    _replyFormController.dispose();
    super.dispose();
  }

  bool _isFormValid() {
    return CustomValidators.validateEmpty(_replyFormController.text) == null;
  }

  bool _isButtonEnabled() {
    return _isFormValid() && !_isProcessing;
  }

  void _updateCharCount() {
    setState(() {
      _charCount = _replyFormController.text.length;
    });
  }

  void _validateField() {
    setState(() {
      _replyFormErrorText =
          CustomValidators.validateEmpty(_replyFormController.text);
    });
  }

  Future<void> _createMessageViaPost() async {
    setState(() {
      _isProcessing = true;
    });
    try {
      await MessageService()
          .createMessageVisPost(_replyFormController.text, widget.postId);
      if (!mounted) return;
      showSuccessSnackBar(context, 'メッセージが正常に送信されました。');
      Navigator.of(context).pop();
    } catch (e) {
      logger.e(e);
      if (mounted) {
        showFailureSnackBar(context, 'メッセージの送信中にエラーが発生しました。');
      }
    } finally {
      setState(() {
        _isProcessing = false;
      });
    }
  }

  Widget _postButton() {
    return TextButton(
      onPressed: _isButtonEnabled() ? _createMessageViaPost : null,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
        decoration: BoxDecoration(
          color: _isButtonEnabled()
              ? Colors.white
              : const Color.fromARGB(108, 255, 255, 255),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: const Text(
          "返信する",
          style: TextStyle(color: Colors.lightGreen, fontSize: 16.0),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppHeader(
        title: '投稿返信',
        actions: [
          _postButton(),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            TextField(
              controller: _replyFormController,
              maxLines: null,
              maxLength: _MAX_POST_LENGTH,
              decoration: InputDecoration(
                hintText: '返信内容を記入...',
                border: InputBorder.none,
                errorText: _replyFormErrorText,
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
