import 'package:simple_sns_app/domain/message/message_entity.dart';
import 'package:simple_sns_app/domain/message/message_repository.dart';

class Pagination {
  final int? cursor;
  final bool? isNext;
  final int? size;
  final String? order;

  Pagination({
    this.cursor,
    this.isNext,
    this.size,
    this.order,
  });
}

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
}
