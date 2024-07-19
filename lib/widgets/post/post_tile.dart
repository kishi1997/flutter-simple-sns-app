import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_sns_app/domain/post/post_entity.dart';
import 'package:simple_sns_app/domain/post/post_service.dart';
import 'package:simple_sns_app/utils/date_utils.dart';
import 'package:simple_sns_app/utils/logger_utils.dart';
import 'package:simple_sns_app/utils/provider_utils.dart';
import 'package:simple_sns_app/utils/snack_bar_utils.dart';
import 'package:simple_sns_app/widgets/post/reply_post_form.dart';

class PostTile extends StatefulWidget {
  final Post post;
  final Function(int) onDelete;

  const PostTile({
    super.key,
    required this.post,
    required this.onDelete,
  });

  @override
  PostTileState createState() => PostTileState();
}

class PostTileState extends State<PostTile> {
  Future<void> deletePost(int postId) async {
    try {
      await PostService().delete(postId);
      if (!mounted) return;
      widget.onDelete(postId);
      showSnackBar(context, '投稿を削除しました');
    } catch (e) {
      logger.e(e);
      if (mounted) {
        showSnackBar(context, '投稿の削除に失敗しました');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final postAuthor = widget.post.user;
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
                  formatDate(widget.post.createdAt),
                  style: const TextStyle(fontSize: 10, color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
        subtitle: Text(widget.post.body, style: const TextStyle(fontSize: 16)),
        trailing: PopupMenuButton<String>(
          onSelected: (value) {
            if (value == 'delete') {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('確認'),
                    content: const Text('この投稿を削除しますか？'),
                    actions: [
                      TextButton(
                        child: const Text('キャンセル'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: const Text('削除'),
                        onPressed: () {
                          deletePost(widget.post.id);
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            }
          },
          itemBuilder: (BuildContext context) {
            return [
              const PopupMenuItem<String>(
                value: 'delete',
                child: Text('削除'),
              ),
            ];
          },
          icon: Transform.rotate(
            angle: 90 * 3.1415927 / 180,
            child: const Icon(Icons.more_vert),
          ),
        ),
      ),
      if (!currentUserIsAuthor)
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: ReplyPostForm(
            postId: widget.post.id,
          ),
        )
    ]);
  }
}
