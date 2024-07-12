import 'package:json_annotation/json_annotation.dart';

part 'user_entity.g.dart';

@JsonSerializable()
class User {
  final int id;
  final String name;
  final String email;
  final String? iconImageUrl;

  User({
    required this.id,
    required this.name,
    required this.email,
    this.iconImageUrl,
  });

  // JSONをUserオブジェクトに変換するファクトリコンストラクタ
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  // UserオブジェクトをJSONに変換するメソッド
  Map<String, dynamic> toJson() => _$UserToJson(this);
  // @override
  // String toString() {
  //   return 'Account{id: $id, name: $name, email: $email, iconImageUrl: $iconImageUrl}';
  // }
}
