import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_sns_app/domain/post/post_entity.dart';
import 'package:simple_sns_app/domain/post/post_service.dart';
import 'package:simple_sns_app/utils/date_utils.dart';
import 'package:simple_sns_app/utils/icons_utils.dart';
import 'package:simple_sns_app/utils/logger_utils.dart';
import 'package:simple_sns_app/utils/provider_utils.dart';
import 'package:simple_sns_app/utils/snack_bar_utils.dart';
import 'package:simple_sns_app/widgets/user/uset_icon.dart';

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
      showSuccessSnackBar(context, '投稿を削除しました');
    } catch (e) {
      logger.e(e);
      if (mounted) {
        showFailureSnackBar(context, '投稿の削除に失敗しました');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final postAuthor = widget.post.user;
    final currentUser = Provider.of<UserProvider>(context).user;
    bool currentUserIsAuthor = currentUser?.id == postAuthor?.id;
    return Column(children: [
      Container(
          padding: const EdgeInsets.all(24.0),
          decoration: const BoxDecoration(
              border: Border(
                  bottom: BorderSide(
            color: Colors.grey,
            width: 1.0,
          ))),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  UserIcon(iconImageUrl: postAuthor?.iconImageUrl),
                  const SizedBox(width: 12.0),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        postAuthor?.name ?? 'Unknown User',
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      Text(widget.post.body,
                          style: const TextStyle(fontSize: 16)),
                      if (!currentUserIsAuthor)
                        Container(
                            padding: const EdgeInsets.only(top: 16.0),
                            child: const Align(
                                alignment: Alignment.centerLeft,
                                child: Icon(MyFlutterApp.comment_empty,
                                    color: Colors.grey, size: 16.0)))
                    ],
                  )),
                  const SizedBox(width: 12.0),
                  Text(
                    formatRelativeTime(widget.post.createdAt),
                    style: const TextStyle(fontSize: 10, color: Colors.grey),
                  ),
                  const SizedBox(width: 12.0),
                  PopupMenuButton<String>(
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
                          child: Text('投稿を削除する'),
                        ),
                      ];
                    },
                    child: Positioned(
                        top: 0,
                        right: 0,
                        child: Transform.rotate(
                          angle: 90 * 3.1415927 / 180,
                          child: const Icon(
                            Icons.more_vert,
                            size: 24.0,
                            color: Colors.grey,
                          ),
                        )),
                  ),
                ],
              ),
            ],
          ))
    ]);
  }
}
