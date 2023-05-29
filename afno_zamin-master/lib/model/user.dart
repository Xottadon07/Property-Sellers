// model for signup and login
import 'package:json_annotation/json_annotation.dart';
part 'user.g.dart';

@JsonSerializable()
class User {
  String email;
  String password;
  String username;
  String phoneNumber;

  User(this.username, this.password, this.phoneNumber, this.email);
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
