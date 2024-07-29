import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_sns_app/domain/message/message_entity.dart';
import 'package:simple_sns_app/domain/room/room_entity.dart';
import 'package:simple_sns_app/domain/room_user/room_user_entity.dart';
import 'package:simple_sns_app/screens/room/room_screen.dart';
import 'package:simple_sns_app/utils/date_utils.dart';
import 'package:simple_sns_app/utils/provider_utils.dart';

class RoomTile extends StatefulWidget {
  final Room room;

  const RoomTile({
    super.key,
    required this.room,
  });

  @override
  RoomTileState createState() => RoomTileState();
}

class RoomTileState extends State<RoomTile> {
  RoomUser _getChatPartner(Room room, int currentUserId) {
    return room.roomUsers.firstWhere((user) => user.userId != currentUserId);
  }

  Message _getLatestMessage(Room room) {
    room.messages.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return room.messages.first;
  }

  Widget _buildAvatar(String? iconImageUrl) {
    if (iconImageUrl == null) {
      return const CircleAvatar(
        child: Icon(Icons.person),
      );
    }
    return CircleAvatar(
      backgroundImage: NetworkImage(iconImageUrl),
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = Provider.of<UserProvider>(context).user;
    final chatPartner = _getChatPartner(widget.room, currentUser!.id);
    final latestMessage = _getLatestMessage(widget.room);
    return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => RoomScreen(
                    roomId: widget.room.id,
                    chatPartnerName: chatPartner.user!.name)),
          );
        },
        child: Column(children: [
          const SizedBox(height: 24),
          ListTile(
            leading: _buildAvatar(chatPartner.user?.iconImageUrl),
            title: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: Text(
                      chatPartner.user?.name != null
                          ? chatPartner.user!.name
                          : 'Unknown User',
                    )),
                    const SizedBox(width: 8.0),
                    Text(
                      formatLatestMessageRelativeTime(latestMessage.createdAt),
                      style: const TextStyle(fontSize: 10, color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
            subtitle: Text(latestMessage.content,
                style: const TextStyle(fontSize: 14, color: Colors.grey)),
            isThreeLine: true,
          ),
        ]));
  }
}
