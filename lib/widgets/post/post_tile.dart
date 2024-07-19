import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_sns_app/domain/post/post_entity.dart';
import 'package:simple_sns_app/utils/date_utils.dart';
import 'package:simple_sns_app/utils/provider_utils.dart';
import 'package:simple_sns_app/widgets/post/reply_post_form.dart';

class PostTile extends StatelessWidget {
  final Post post;

  const PostTile({
    super.key,
    required this.post,
  });

  @override
  Widget build(BuildContext context) {
    final postAuthor = post.user;
    final currentUser = Provider.of<UserProvider>(context).user;
    bool currentUserIsAuthor = currentUser?.id == postAuthor?.id;
    return Column(children: [
      const SizedBox(height: 24),
      ListTile(
        leading: CircleAvatar(
          backgroundImage: postAuthor?.iconImageUrl != null
              ? NetworkImage(postAuthor!.iconImageUrl!)
              : null,
          child: postAuthor?.iconImageUrl == null
              ? const Icon(Icons.person)
              : null,
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                    postAuthor?.name != null
                        ? postAuthor!.name
                        : 'Unknown User',
                    style: const TextStyle(fontSize: 12)),
                const SizedBox(width: 8.0),
                Text(
                  formatDate(post.createdAt),
                  style: const TextStyle(fontSize: 10, color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
        subtitle: Text(post.body, style: const TextStyle(fontSize: 16)),
        trailing: Transform.rotate(
          angle: 90 * 3.1415927 / 180,
          child: const Icon(Icons.more_vert),
        ),
      ),
      if (!currentUserIsAuthor)
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: ReplyPostForm(
            postId: post.id,
          ),
        )
    ]);
  }
}
