import 'package:flutter/material.dart';
import 'package:simple_sns_app/domain/message/message_service.dart';
import 'package:simple_sns_app/utils/logger_utils.dart';
import 'package:simple_sns_app/utils/snack_bar_utils.dart';
import 'package:simple_sns_app/utils/validation_utils.dart';

class ReplyPostForm extends StatefulWidget {
  final int postId;

  const ReplyPostForm({
    super.key,
    required this.postId,
  });

  @override
  ReplyPostFormState createState() => ReplyPostFormState();
}

class ReplyPostFormState extends State<ReplyPostForm> {
  final TextEditingController _replyController = TextEditingController();
  bool _isProcessing = false;
  String? _replyErrorText;

  @override
  void initState() {
    super.initState();
    _replyController.addListener(() => _validateField());
  }

  @override
  void dispose() {
    _replyController.dispose();
    super.dispose();
  }

  bool _isFormValid() {
    return CustomValidators.validateEmpty(_replyController.text) == null;
  }

  void _validateField() {
    setState(() {
      _replyErrorText = CustomValidators.validateEmpty(_replyController.text);
    });
  }

  bool _isButtonEnabled() {
    return _isFormValid() && !_isProcessing;
  }

  Future<void> _createMessageViaPost(String content, int postId) async {
    setState(() {
      _isProcessing = true;
    });
    try {
      await MessageService().createMessageVisPost(content, postId);
      if (!mounted) return;
      showSuccessSnackBar(context, 'メッセージが正常に送信されました。');
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

  void _handleSendMessage(String message, int postId) async {
    await _createMessageViaPost(message, postId);
    _replyController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _replyController,
            style: const TextStyle(fontSize: 14),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(
                  top: 1.0, bottom: 1.0, left: 8.0, right: 8.0),
              border: const OutlineInputBorder(),
              hintText: '返信する',
              errorText: _replyErrorText,
              hintStyle: const TextStyle(color: Colors.grey),
              suffixIcon: IconButton(
                icon: const Icon(Icons.send),
                iconSize: 14,
                color: _isButtonEnabled()
                    ? Theme.of(context).primaryColor
                    : Colors.grey,
                onPressed: () async {
                  _isButtonEnabled()
                      ? _handleSendMessage(_replyController.text, widget.postId)
                      : null;
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
