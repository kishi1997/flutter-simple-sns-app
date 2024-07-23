import 'package:json_annotation/json_annotation.dart';
import '../user/user_entity.dart';

part 'room_user_entity.g.dart';

@JsonSerializable()
class RoomUser {
  final String roomId;
  final int userId;
  final User? user;

  RoomUser({
    required this.roomId,
    required this.userId,
    this.user,
  });

  factory RoomUser.fromJson(Map<String, dynamic> json) =>
      _$RoomUserFromJson(json);

  Map<String, dynamic> toJson() => _$RoomUserToJson(this);
}
