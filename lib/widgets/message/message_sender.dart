import 'package:flutter/material.dart';
import 'package:simple_sns_app/domain/message/message_entity.dart';
import 'package:simple_sns_app/domain/message/message_service.dart';
import 'package:simple_sns_app/utils/logger_utils.dart';
import 'package:simple_sns_app/utils/snack_bar_utils.dart';
import 'package:simple_sns_app/utils/validation_utils.dart';

class MessageSender extends StatefulWidget {
  final String roomId;
  final void Function(Message) onMessageSent;
  const MessageSender(
      {super.key, required this.roomId, required this.onMessageSent});

  @override
  MessageSenderState createState() => MessageSenderState();
}

class MessageSenderState extends State<MessageSender> {
  final TextEditingController _messageController = TextEditingController();
  String? _messageErrorText;
  bool _isProcessing = false;

  @override
  void initState() {
    super.initState();
    _messageController.addListener(() {
      _validateField();
    });
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _createMessage(String content, String roomId) async {
    setState(() {
      _isProcessing = true;
    });
    try {
      final newMessage = await MessageService().createMessage(content, roomId);
      widget.onMessageSent(newMessage);
      _messageController.clear();
    } catch (e) {
      logger.e(e);
      if (mounted) {
        showSnackBar(context, 'メッセージの送信中にエラーが発生しました。');
      }
    } finally {
      setState(() {
        _isProcessing = false;
      });
    }
  }

  bool _isFormValid() {
    return CustomValidators.validateEmpty(_messageController.text) == null;
  }

  void _validateField() {
    setState(() {
      _messageErrorText =
          CustomValidators.validateEmpty(_messageController.text);
    });
  }

  bool _isButtonEnabled() {
    return _isFormValid() && !_isProcessing;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: TextField(
            controller: _messageController,
            style: const TextStyle(fontSize: 14),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(8.0),
              border: const OutlineInputBorder(),
              hintText: 'メッセージを入力',
              hintStyle: const TextStyle(color: Colors.grey),
              errorText: _messageErrorText,
            ),
          ),
        ),
        const SizedBox(width: 12.0),
        Container(
          decoration: BoxDecoration(
            color: _isFormValid() && !_isProcessing
                ? Colors.lightGreen
                : Colors.grey[200],
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: IconButton(
            icon: const Icon(Icons.send, color: Colors.white),
            iconSize: 20,
            onPressed: () async {
              _isButtonEnabled()
                  ? _createMessage(_messageController.text, widget.roomId)
                  : null;
            },
          ),
        ),
      ],
    );
  }
}
