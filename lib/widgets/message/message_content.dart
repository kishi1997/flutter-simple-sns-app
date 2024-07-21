import 'package:flutter/material.dart';
import 'package:simple_sns_app/domain/message/message_entity.dart';
import 'package:simple_sns_app/domain/post/post_entity.dart';
import 'package:simple_sns_app/utils/date_utils.dart';

class MessageContentWithPost extends StatelessWidget {
  final Post post;
  final bool isCurrentUser;

  const MessageContentWithPost(
      {super.key, required this.post, required this.isCurrentUser});

  @override
  Widget build(BuildContext context) {
    final postAuthor = post.user;
    final postAuthorIcon = Container(
      decoration: BoxDecoration(
        image: postAuthor?.iconImageUrl != null
            ? DecorationImage(
                image: NetworkImage(postAuthor!.iconImageUrl!),
                fit: BoxFit.cover,
              )
            : null,
        color: Colors.grey[200],
        shape: BoxShape.rectangle,
      ),
      child: postAuthor?.iconImageUrl == null
          ? const Icon(
              Icons.person,
              size: 10.0,
            )
          : null,
    );

    return Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Column(
          crossAxisAlignment:
              isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            const Text(
              "投稿に返信しました",
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(height: 8.0),
            Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color.fromARGB(255, 225, 225, 225),
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SizedBox(
                          width: 20.0, height: 20.0, child: postAuthorIcon),
                      const SizedBox(width: 8.0),
                      Text(
                        postAuthor?.name ?? 'Unknown User',
                        style: const TextStyle(fontSize: 12),
                      ),
                      const SizedBox(width: 8.0),
                      Text(
                        formatMonthDay(post.createdAt),
                        style:
                            const TextStyle(fontSize: 10, color: Colors.grey),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          post.body,
                          style: const TextStyle(fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}

class MessageContent extends StatelessWidget {
  final Message message;
  final bool isCurrentUser;

  const MessageContent({
    super.key,
    required this.message,
    required this.isCurrentUser,
  });

  @override
  Widget build(BuildContext context) {
    final messageSender = message.user;
    final formattedDate = formatMonthDay(message.createdAt);
    final profileIcon = !isCurrentUser
        ? SizedBox(
            width: 40.0,
            height: 40.0,
            child: CircleAvatar(
              backgroundImage: messageSender?.iconImageUrl != null
                  ? NetworkImage(messageSender!.iconImageUrl!)
                  : null,
              child: messageSender?.iconImageUrl == null
                  ? const Icon(Icons.person)
                  : null,
            ),
          )
        : const SizedBox.shrink();

    final dateText = Text(
      formattedDate,
      style: const TextStyle(fontSize: 10, color: Colors.grey),
    );

    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (isCurrentUser) dateText,
        profileIcon,
        const SizedBox(width: 8.0),
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
        if (!isCurrentUser) ...[const SizedBox(width: 8.0), dateText]
      ],
    );
  }
}
