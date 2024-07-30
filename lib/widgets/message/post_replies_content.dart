import 'package:flutter/material.dart';
import 'package:simple_sns_app/domain/post/post_entity.dart';
import 'package:simple_sns_app/domain/user/user_entity.dart';
import 'package:simple_sns_app/utils/date_utils.dart';

class PostRepliesContent extends StatelessWidget {
  final Post post;
  final bool isCurrentUser;

  const PostRepliesContent(
      {super.key, required this.post, required this.isCurrentUser});

  Widget _buildPostAuthorIcon(User? postAuthor) {
    return Container(
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
  }

  @override
  Widget build(BuildContext context) {
    final postAuthor = post.user;
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
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                          width: 20.0,
                          height: 20.0,
                          child: _buildPostAuthorIcon(postAuthor)),
                      const SizedBox(width: 8.0),
                      Expanded(
                          child: Text(
                        postAuthor!.name,
                        style: const TextStyle(fontSize: 12),
                      )),
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
