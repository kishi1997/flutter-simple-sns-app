import 'package:flutter/material.dart';
import 'package:simple_sns_app/domain/message/message_entity.dart';
import 'package:simple_sns_app/widgets/message/message_item.dart';

class MessageList extends StatefulWidget {
  final List<Message> messages;
  final Future<void> Function(int cursor) fetchMessages;
  final bool hasMoreData;

  const MessageList({
    super.key,
    required this.messages,
    required this.fetchMessages,
    required this.hasMoreData,
  });

  @override
  MessageListState createState() => MessageListState();
}

class MessageListState extends State<MessageList> {
  late ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(() async {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent * 0.9 &&
          widget.hasMoreData) {
        int cursor = widget.messages.last.id;
        await widget.fetchMessages(cursor);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: _scrollController,
      reverse: true,
      itemCount: widget.messages.length + 1,
      itemBuilder: (BuildContext context, int index) {
        if (index == widget.messages.length) {
          if (!widget.hasMoreData) return const SizedBox.shrink();
          return const Padding(
            padding: EdgeInsets.all(12.0),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        return MessageItem(
          message: widget.messages[index],
        );
      },
    );
  }
}
