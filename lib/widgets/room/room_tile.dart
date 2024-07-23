import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_sns_app/domain/room/room_entity.dart';
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
  @override
  Widget build(BuildContext context) {
    final currentUser = Provider.of<UserProvider>(context).user;
    final chatPartner = widget.room.roomUsers
        .firstWhere((user) => user.userId != currentUser?.id);
    widget.room.messages.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    final latestMessage = widget.room.messages.first;
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
            leading: CircleAvatar(
              backgroundImage: chatPartner.user?.iconImageUrl != null
                  ? NetworkImage(chatPartner.user!.iconImageUrl!)
                  : null,
              child: chatPartner.user?.iconImageUrl == null
                  ? const Icon(Icons.person)
                  : null,
            ),
            title: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                        chatPartner.user?.name != null
                            ? chatPartner.user!.name
                            : 'Unknown User',
                        style: const TextStyle(fontSize: 12)),
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
                style: const TextStyle(fontSize: 16)),
          ),
        ]));
  }
}
