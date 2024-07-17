import 'package:flutter/material.dart';
import 'package:simple_sns_app/domain/post/post_entity.dart';
import 'package:simple_sns_app/utils/date_utils.dart';

class PostListTile extends StatelessWidget {
  final Post post;

  const PostListTile({
    super.key,
    required this.post,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: post.user.iconImageUrl != null
            ? NetworkImage(post.user.iconImageUrl!)
            : null,
        child: post.user.iconImageUrl == null ? const Icon(Icons.person) : null,
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(post.user.name, style: const TextStyle(fontSize: 12)),
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
    );
  }
}
