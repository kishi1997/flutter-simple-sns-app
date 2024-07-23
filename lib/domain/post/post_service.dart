import 'package:simple_sns_app/domain/post/post_entity.dart';
import 'package:simple_sns_app/domain/post/post_repository.dart';

class PostService {
  Future<Post> createPost(String content) async {
    final post = await PostRepository().createPost(content);
    return post;
  }

  Future<List<Post>> getPosts() async {
    final posts = await PostRepository().getPosts();
    return posts;
  }

  Future<void> delete(int postId) async {
    await PostRepository().delete(postId);
  }
}
