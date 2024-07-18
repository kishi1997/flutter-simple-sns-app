import 'package:simple_sns_app/domain/post/post_entity.dart';
import 'package:simple_sns_app/domain/post/post_repository.dart';

class PostService {
  Future<List<Post>> getPosts() async {
    final posts = await PostRepository().getPosts();
    return posts;
  }

  Future<void> delete(int postId) async {
    await PostRepository().delete(postId);
  }
}
