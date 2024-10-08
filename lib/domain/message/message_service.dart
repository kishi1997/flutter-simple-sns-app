import 'package:simple_sns_app/domain/message/message_entity.dart';
import 'package:simple_sns_app/domain/message/message_repository.dart';
import 'package:simple_sns_app/utils/pagination_utils.dart';

class MessageService {
  Future<List<Message>> getMessages(String roomId,
      [Pagination? pagination]) async {
    final messages = await MessageRepository().getMessages(roomId, pagination);
    return messages;
  }

  Future<Message> createMessageVisPost(String content, int postId) async {
    final message =
        await MessageRepository().createMessageVisPost(content, postId);
    return message;
  }

  Future<Message> createMessage(String content, String roomId) async {
    final message = await MessageRepository().createMessage(content, roomId);
    return message;
  }
}
