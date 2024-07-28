import 'package:simple_sns_app/domain/post/post_entity.dart';
import 'package:simple_sns_app/utils/api.dart';
import 'package:simple_sns_app/utils/pagination_utils.dart';

class PostRepository {
  Future<Post> createPost(String content) async {
    try {
      final res = await api.post(
        '/posts',
        data: {
          "post": {
            "body": content,
          }
        },
      );
      return Post.fromJson(res.data["post"]);
    } catch (e) {
      throw Exception('Failed to create post: $e');
    }
  }

  Future<List<Post>> getPosts([Pagination? pagination]) async {
    try {
      final queryParameters = buildPagiationParameters(pagination);
      final res = await api.get(
        '/posts',
        queryParameters: queryParameters,
      );
      final posts = (res.data['posts'] as List<dynamic>)
          .map((post) => Post.fromJson(post as Map<String, dynamic>))
          .toList();
      return posts;
    } catch (e) {
      throw Exception('Failed to get posts: $e');
    }
  }

  Future<void> delete(int postId) async {
    try {
      await api.delete('/posts/$postId');
    } catch (e) {
      throw Exception('Failed to delete post: $e');
    }
  }
}
