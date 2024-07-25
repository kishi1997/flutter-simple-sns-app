import 'package:flutter/material.dart';
import 'package:simple_sns_app/components/header/app_header.dart';
import 'package:simple_sns_app/domain/post/post_entity.dart';
import 'package:simple_sns_app/domain/post/post_service.dart';
import 'package:simple_sns_app/screens/post/post_creation_screen.dart';
import 'package:simple_sns_app/utils/logger_utils.dart';
import 'package:simple_sns_app/widgets/post/post_tile.dart';

class PostListScreen extends StatefulWidget {
  const PostListScreen({super.key});
  @override
  PostListState createState() => PostListState();
}

class PostListState extends State<PostListScreen> {
  List<Post> _posts = [];
  Future<void> fetchPosts() async {
    try {
      final posts = await PostService().getPosts();
      setState(() {
        _posts = posts;
      });
    } catch (e) {
      logError(e);
    }
  }

  @override
  void initState() {
    super.initState();
    fetchPosts();
  }

  void _removePost(int postId) {
    setState(() {
      _posts.removeWhere((post) => post.id == postId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppHeader(title: '投稿一覧'),
      body: Padding(
          padding: const EdgeInsets.only(
            top: 0,
            right: 24.0,
            bottom: 24.0,
            left: 24.0,
          ),
          child: RefreshIndicator(
            color: Theme.of(context).primaryColor,
            onRefresh: () async {
              await fetchPosts();
            },
            child: Center(
              child: ListView.builder(
                itemCount: _posts.length,
                itemBuilder: (BuildContext context, int index) {
                  final post = _posts[index];
                  return PostTile(
                    post: post,
                    onDelete: _removePost,
                  );
                },
              ),
            ),
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const PostCreationScreen()),
          );
        },
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        tooltip: 'Create Post',
        child: const Icon(Icons.edit),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
