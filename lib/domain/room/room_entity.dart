import 'package:json_annotation/json_annotation.dart';
import 'package:simple_sns_app/domain/message/message_entity.dart';
import 'package:simple_sns_app/domain/room_user/room_user_entity.dart';

part 'room_entity.g.dart';

@JsonSerializable()
class Room {
  final String id;
  final List<Message> messages;
  final List<RoomUser> roomUsers;

  Room({
    required this.id,
    required this.messages,
    required this.roomUsers,
  });

  factory Room.fromJson(Map<String, dynamic> json) => _$RoomFromJson(json);

  Map<String, dynamic> toJson() => _$RoomToJson(this);
}
