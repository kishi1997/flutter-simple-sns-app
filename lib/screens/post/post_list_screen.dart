import 'package:flutter/material.dart';
import 'package:simple_sns_app/components/header/app_header.dart';
import 'package:simple_sns_app/domain/post/post_entity.dart';
import 'package:simple_sns_app/domain/post/post_service.dart';
import 'package:simple_sns_app/screens/signin_screen.dart';
import 'package:simple_sns_app/widgets/post/post_list_tile.dart';

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
                  return PostListTile(post: post);
                },
              ),
            )));
  }
}
