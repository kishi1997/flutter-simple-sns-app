import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_sns_app/domain/message/message_entity.dart';
import 'package:simple_sns_app/utils/provider_utils.dart';
import 'package:simple_sns_app/widgets/message/message_content.dart';

class MessageItem extends StatelessWidget {
  final Message message;

  const MessageItem({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    final currentUser = Provider.of<UserProvider>(context).user;
    bool isCurrentUser = currentUser?.id == message.userId;
    return Column(
      children: [
        const SizedBox(height: 24),
        if (message.post != null)
          Padding(
            padding: EdgeInsets.only(
              left: isCurrentUser ? 48.0 : 0.0,
              right: isCurrentUser ? 0.0 : 40.0,
            ),
            child: MessageContentWithPost(
                post: message.post!, isCurrentUser: isCurrentUser),
          ),
        Padding(
          padding: EdgeInsets.only(
            left: isCurrentUser ? 48.0 : 0.0,
            right: isCurrentUser ? 0.0 : 40.0,
          ),
          child: MessageContent(
            message: message,
            isCurrentUser: isCurrentUser,
          ),
        ),
      ],
    );
  }
}
