import 'package:simple_sns_app/domain/message/message_entity.dart';
import 'package:simple_sns_app/domain/message/message_repository.dart';

class MessageService {
  Future<List<Message>> getMessages(String roomId) async {
    final messages = await MessageRepository().getMessages(roomId);
    return messages;
  }

  Future<Message> createMessageVisPost(String content, int postId) async {
    final message =
        await MessageRepository().createMessageVisPost(content, postId);
    return message;
  }
}
