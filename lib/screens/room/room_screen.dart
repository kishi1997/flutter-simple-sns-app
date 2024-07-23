import 'package:flutter/material.dart';
import 'package:simple_sns_app/components/header/app_header.dart';
import 'package:simple_sns_app/domain/message/message_entity.dart';
import 'package:simple_sns_app/domain/message/message_service.dart';
import 'package:simple_sns_app/utils/logger_utils.dart';
import 'package:simple_sns_app/widgets/message/message_item.dart';
import 'package:simple_sns_app/widgets/message/message_sender.dart';

class RoomScreen extends StatefulWidget {
  final String roomId;
  final String chatPartnerName;
  const RoomScreen(
      {super.key, required this.roomId, required this.chatPartnerName});
  @override
  RoomScreenState createState() => RoomScreenState();
}

class RoomScreenState extends State<RoomScreen> {
  List<Message> _messages = [];
  bool _isLoading = false;

  Future<void> fetchMessages() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final messages = await MessageService().getMessages(widget.roomId);
      setState(() {
        _messages = messages;
      });
    } catch (e) {
      logError(e);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchMessages();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget _buildListView() {
    if (_isLoading) return const Center(child: CircularProgressIndicator());
    return ListView.builder(
      reverse: true,
      itemCount: _messages.length,
      itemBuilder: (BuildContext context, int index) {
        final message = _messages[index];
        return MessageItem(
          message: message,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppHeader(title: widget.chatPartnerName),
      body: Container(
        padding: const EdgeInsets.only(
          top: 0,
          right: 24.0,
          bottom: 0,
          left: 24.0,
        ),
        child: Column(
          children: [
            Expanded(child: _buildListView()),
            const SizedBox(height: 24.0),
            MessageSender(roomId: widget.roomId, onMessageSent: fetchMessages),
          ],
        ),
      ),
    );
  }
}
