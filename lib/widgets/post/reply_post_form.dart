import 'package:flutter/material.dart';
import 'package:simple_sns_app/domain/message/message_service.dart';
import 'package:simple_sns_app/utils/logger_utils.dart';
import 'package:simple_sns_app/utils/snack_bar_utils.dart';

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

  Future<void> _createMessageViaPost(String content, int postId) async {
    try {
      await MessageService().createMessageVisPost(content, postId);
      if (!mounted) return;
      showSnackBar(context, 'メッセージが正常に送信されました。');
    } catch (e) {
      logger.e(e);
      if (mounted) {
        showSnackBar(context, 'メッセージの送信中にエラーが発生しました。');
      }
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
              hintStyle: const TextStyle(color: Colors.grey),
              suffixIcon: IconButton(
                icon: const Icon(Icons.send),
                iconSize: 14,
                onPressed: () async {
                  _handleSendMessage(_replyController.text, widget.postId);
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
