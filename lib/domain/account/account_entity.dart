import 'package:json_annotation/json_annotation.dart';
import '../user/user_entity.dart';

part 'account_entity.g.dart';

@JsonSerializable()
class Account {
  final User user;
  final String token;

  Account({
    required this.user,
    required this.token,
  });

  // JSONをApiResponseオブジェクトに変換するファクトリコンストラクタ
  factory Account.fromJson(Map<String, dynamic> json) =>
      _$AccountFromJson(json);

  // ApiResponseオブジェクトをJSONに変換するメソッド
  Map<String, dynamic> toJson() => _$AccountToJson(this);
}
