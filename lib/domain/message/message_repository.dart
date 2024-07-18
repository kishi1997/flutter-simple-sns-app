import 'package:simple_sns_app/domain/message/message_entity.dart';
import 'package:simple_sns_app/utils/api.dart';

class MessageRepository {
  Future<Message> createMessageVisPost(String content, int postId) async {
    try {
      final res = await api.post(
        '/messages/via_post',
        data: {"content": content, "postId": postId},
      );
      return Message.fromJson(res.data["message"]);
    } catch (e) {
      throw Exception('Failed to send message vis post: $e');
    }
  }
}
