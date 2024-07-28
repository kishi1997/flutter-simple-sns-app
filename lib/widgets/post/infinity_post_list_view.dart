import 'package:flutter/material.dart';
import 'package:simple_sns_app/domain/post/post_entity.dart';
import 'package:simple_sns_app/widgets/post/post_tile.dart';

class InfinityPostListView extends StatefulWidget {
  final List<Post> posts;
  final Future<void> Function(int cursor) fetchPosts;
  final bool hasMoreData;

  const InfinityPostListView({
    super.key,
    required this.posts,
    required this.fetchPosts,
    required this.hasMoreData,
  });

  @override
  State<InfinityPostListView> createState() => _InfinityListViewState();
}

class _InfinityListViewState extends State<InfinityPostListView> {
  late ScrollController _scrollController;
  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(() async {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent * 0.9 &&
          widget.hasMoreData) {
        int cursor = widget.posts.last.id;
        await widget.fetchPosts(cursor);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _removePost(int postId) {
    setState(() {
      widget.posts.removeWhere((post) => post.id == postId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: _scrollController,
      itemCount: widget.posts.length + 1,
      itemBuilder: (BuildContext context, int index) {
        if (index == widget.posts.length) {
          if (!widget.hasMoreData) return const SizedBox.shrink();
          return const Padding(
            padding: EdgeInsets.all(12.0),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        return PostTile(
          post: widget.posts[index],
          onDelete: _removePost,
        );
      },
    );
  }
}
