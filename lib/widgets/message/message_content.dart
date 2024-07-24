import 'package:flutter/material.dart';
import 'package:simple_sns_app/domain/message/message_entity.dart';
import 'package:simple_sns_app/utils/date_utils.dart';
import 'package:simple_sns_app/widgets/user/uset_icon.dart';

class MessageContent extends StatelessWidget {
  final Message message;
  final bool isCurrentUser;

  const MessageContent({
    super.key,
    required this.message,
    required this.isCurrentUser,
  });

  Widget _buildMessageDate() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Text(
        formatRelativeTime(message.createdAt),
        style: const TextStyle(fontSize: 10, color: Colors.grey),
      ),
    );
  }

  Widget _buildUserIconBox() {
    if (isCurrentUser) return const SizedBox.shrink();
    return Padding(
        padding: const EdgeInsets.only(right: 8),
        child: SizedBox(
            width: 40.0,
            height: 40.0,
            child: userIcon(message.user?.iconImageUrl)));
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (isCurrentUser) _buildMessageDate(),
        _buildUserIconBox(),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              border: Border.all(
                color: const Color.fromARGB(255, 225, 225, 225),
              ),
              borderRadius: BorderRadius.circular(8.0),
              color: isCurrentUser ? Colors.grey[100] : null,
            ),
            child: Text(
              message.content,
              style: const TextStyle(fontSize: 14),
            ),
          ),
        ),
        if (!isCurrentUser) _buildMessageDate()
      ],
    );
  }
}
