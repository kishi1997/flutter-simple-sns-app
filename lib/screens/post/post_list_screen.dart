import 'package:flutter/material.dart';
import 'package:simple_sns_app/components/header/app_header.dart';
import 'package:simple_sns_app/domain/post/post_entity.dart';
import 'package:simple_sns_app/domain/post/post_service.dart';
import 'package:simple_sns_app/screens/post/post_creation_screen.dart';
import 'package:simple_sns_app/utils/logger_utils.dart';
import 'package:simple_sns_app/utils/pagination_utils.dart';
import 'package:simple_sns_app/widgets/post/post_list.dart';

class PostListScreen extends StatefulWidget {
  const PostListScreen({super.key});
  @override
  PostListState createState() => PostListState();
}

class PostListState extends State<PostListScreen> {
  List<Post> _posts = [];
  late Future<void> _fetchPostsFuture;
  bool _isLoading = false;
  bool _hasMoreData = true;

  Future<void> fetchPosts([int? cursor]) async {
    if (_isLoading || !_hasMoreData) return;
    _isLoading = true;

    try {
      final pagination = Pagination(size: 50, cursor: cursor);
      final newPosts = await PostService().getPosts(pagination);
      _hasMoreData = newPosts.length == 50;
      setState(() {
        if (_posts.isEmpty) {
          _posts = newPosts;
        } else {
          _posts.addAll(newPosts);
        }
      });
    } catch (e) {
      logError(e);
    } finally {
      _isLoading = false;
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchPostsFuture = fetchPosts();
  }

  Future<void> resetAndFetchPosts() async {
    _posts.clear();
    _hasMoreData = true;
    await fetchPosts();
  }

  Widget _buildPostListView() {
    return FutureBuilder(
      future: _fetchPostsFuture,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }
        return PostList(
            posts: _posts,
            fetchPosts: (cursor) => fetchPosts(cursor),
            hasMoreData: _hasMoreData);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppHeader(title: '投稿一覧'),
      body: (RefreshIndicator(
          color: Theme.of(context).primaryColor,
          onRefresh: () async {
            resetAndFetchPosts();
          },
          child: _buildPostListView())),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const PostCreationScreen()),
          );
          resetAndFetchPosts();
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
