// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room_user_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RoomUser _$RoomUserFromJson(Map<String, dynamic> json) => RoomUser(
      roomId: json['roomId'] as String,
      userId: (json['userId'] as num).toInt(),
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RoomUserToJson(RoomUser instance) => <String, dynamic>{
      'roomId': instance.roomId,
      'userId': instance.userId,
      'user': instance.user,
    };
