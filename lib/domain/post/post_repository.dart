import 'package:simple_sns_app/domain/post/post_entity.dart';
import 'package:simple_sns_app/utils/api.dart';

class PostRepository {
  Future<List<Post>> getPosts() async {
    try {
      final res = await apiClient.dio.get('/posts');
      final posts = (res.data['posts'] as List<dynamic>)
          .map((post) => Post.fromJson(post as Map<String, dynamic>))
          .toList();
      return posts;
    } catch (e) {
      throw Exception('Failed to get posts: $e');
    }
  }
}
