import 'package:json_annotation/json_annotation.dart';
import '../user/user_entity.dart';

part 'post_entity.g.dart';

@JsonSerializable()
class Post {
  final int id;
  final int userId;
  final String body;
  final DateTime createdAt;
  final DateTime updatedAt;
  final User? user;

  Post({
    required this.id,
    required this.body,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
    this.user,
  });

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);

  Map<String, dynamic> toJson() => _$PostToJson(this);
}
