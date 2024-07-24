import 'package:flutter/material.dart';
import 'package:simple_sns_app/utils/validation_utils.dart';

class MessageSender extends StatefulWidget {
  const MessageSender({super.key});

  @override
  MessageSenderState createState() => MessageSenderState();
}

class MessageSenderState extends State<MessageSender> {
  final TextEditingController _messageController = TextEditingController();
  String? _messageErrorText;

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

  void _sendMessage() async {
    // メッセージ送信のロジック
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
            color: _isFormValid() ? Colors.lightGreen : Colors.grey[200],
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: IconButton(
            icon: const Icon(Icons.send, color: Colors.white),
            iconSize: 20,
            onPressed: _isFormValid() ? _sendMessage : null,
          ),
        ),
      ],
    );
  }
}
