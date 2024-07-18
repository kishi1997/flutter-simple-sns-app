import 'package:json_annotation/json_annotation.dart';

part 'user_entity.g.dart';

@JsonSerializable()
class User {
  final int id;
  final String name;
  final String? email;
  final String? iconImageUrl;

  User({
    required this.id,
    required this.name,
    this.email,
    this.iconImageUrl,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
