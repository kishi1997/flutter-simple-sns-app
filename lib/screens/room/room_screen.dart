import 'package:flutter/material.dart';
import 'package:simple_sns_app/components/header/app_header.dart';
import 'package:simple_sns_app/domain/message/message_entity.dart';
import 'package:simple_sns_app/domain/message/message_service.dart';
import 'package:simple_sns_app/utils/logger_utils.dart';
import 'package:simple_sns_app/utils/pagination_utils.dart';
import 'package:simple_sns_app/widgets/message/message_sender.dart';
import 'package:simple_sns_app/widgets/message/message_list.dart';

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
  late Future<void> _fetchMessagesFuture;
  bool _isLoading = false;
  bool _hasMoreData = true;

  @override
  void initState() {
    super.initState();
    _fetchMessagesFuture = fetchMessages();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> fetchMessages([int? cursor]) async {
    if (_isLoading || !_hasMoreData) return;
    _isLoading = true;
    try {
      final pagination = Pagination(size: 50, cursor: cursor);
      final newMessages =
          await MessageService().getMessages(widget.roomId, pagination);
      _hasMoreData = newMessages.length == 50;
      setState(() {
        if (_messages.isEmpty) {
          _messages = newMessages;
        } else {
          _messages.addAll(newMessages);
        }
      });
    } catch (e) {
      logError(e);
    } finally {
      _isLoading = false;
    }
  }

  void _addNewMessage(Message newMessage) {
    setState(() {
      _messages.insert(0, newMessage);
    });
  }

  Widget _buildMessageListView() {
    return FutureBuilder(
      future: _fetchMessagesFuture,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }
        return MessageList(
          messages: _messages,
          fetchMessages: (cursor) => fetchMessages(cursor),
          hasMoreData: _hasMoreData,
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
            Expanded(child: _buildMessageListView()),
            const SizedBox(height: 24.0),
            MessageSender(roomId: widget.roomId, onMessageSent: _addNewMessage),
          ],
        ),
      ),
    );
  }
}
