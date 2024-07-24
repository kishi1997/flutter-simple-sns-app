import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_sns_app/domain/message/message_entity.dart';
import 'package:simple_sns_app/utils/provider_utils.dart';
import 'package:simple_sns_app/widgets/message/message_content.dart';
import 'package:simple_sns_app/widgets/message/post_replies_content.dart';

class MessageItem extends StatelessWidget {
  final Message message;

  const MessageItem({
    super.key,
    required this.message,
  });

  Widget _buildBody(bool isCurrentUser) {
    if (message.post != null) {
      return Column(
        children: [
          PostRepliesContent(
            post: message.post!,
            isCurrentUser: isCurrentUser,
          ),
          MessageContent(
            message: message,
            isCurrentUser: isCurrentUser,
          ),
        ],
      );
    }
    return MessageContent(
      message: message,
      isCurrentUser: isCurrentUser,
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = Provider.of<UserProvider>(context).user;
    bool isCurrentUser = currentUser?.id == message.userId;
    return Column(
      children: [
        const SizedBox(height: 24),
        Padding(
          padding: EdgeInsets.only(
            left: isCurrentUser ? 48.0 : 0.0,
            right: isCurrentUser ? 0.0 : 40.0,
          ),
          child: _buildBody(isCurrentUser),
        ),
      ],
    );
  }
}
