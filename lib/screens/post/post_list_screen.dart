import 'package:flutter/material.dart';
import 'package:simple_sns_app/components/header/app_header.dart';
import 'package:simple_sns_app/domain/post/post_entity.dart';
import 'package:simple_sns_app/domain/post/post_service.dart';
import 'package:simple_sns_app/screens/signin_screen.dart';
import 'package:simple_sns_app/utils/date_utils.dart';

class PostListScreen extends StatefulWidget {
  const PostListScreen({super.key});
  @override
  PostListState createState() => PostListState();
}

class PostListState extends State<PostListScreen> {
  List<Post> _posts = [];
  Future<void> getPosts() async {
    try {
      final posts = await PostService().getPosts();
      setState(() {
        _posts = posts;
      });
    } catch (e) {
      logger.e(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const AppHeader(title: '投稿一覧'),
        body: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Center(
              child: ListView.builder(
                itemCount: _posts.length,
                itemBuilder: (BuildContext context, int index) {
                  final post = _posts[index];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: post.user.iconImageUrl != null
                          ? NetworkImage(post.user.iconImageUrl!)
                          : null,
                      child: post.user.iconImageUrl == null
                          ? const Icon(Icons.person)
                          : null,
                    ),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(post.user.name),
                            const SizedBox(width: 8.0),
                            Text(
                              formatDate(post.createdAt),
                              style: const TextStyle(fontSize: 10),
                            ),
                          ],
                        ),
                      ],
                    ),
                    subtitle: Text(post.body),
                    trailing: Transform.rotate(
                      angle: 90 * 3.1415927 / 180,
                      child: const Icon(Icons.more_vert),
                    ),
                  );
                },
              ),
            )));
  }
}
