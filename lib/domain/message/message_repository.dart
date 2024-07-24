import 'package:simple_sns_app/domain/message/message_entity.dart';
import 'package:simple_sns_app/utils/api.dart';

class MessageRepository {
  Future<List<Message>> getMessages(String roomId) async {
    try {
      final res = await api.get(
        '/messages',
        queryParameters: {
          'roomId': roomId,
        },
      );
      final messages = (res.data['messages'] as List<dynamic>)
          .map((message) => Message.fromJson(message as Map<String, dynamic>))
          .toList();
      return messages;
    } catch (e) {
      throw Exception('Failed to get messages: $e');
    }
  }

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
