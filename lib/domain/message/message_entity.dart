import 'package:json_annotation/json_annotation.dart';
import 'package:simple_sns_app/domain/user/user_entity.dart';
import 'package:simple_sns_app/domain/post/post_entity.dart';

part 'message_entity.g.dart';

@JsonSerializable()
class Message {
  final int id;
  final String content;
  final int? userId;
  final String roomId;
  final int? postId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final User? user;
  final Post? post;

  Message({
    required this.id,
    required this.content,
    this.userId,
    required this.roomId,
    this.postId,
    required this.createdAt,
    required this.updatedAt,
    this.user,
    this.post,
  });

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);

  Map<String, dynamic> toJson() => _$MessageToJson(this);
}
