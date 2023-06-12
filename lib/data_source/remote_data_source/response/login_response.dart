import 'package:artsy/model/user.dart';
import 'package:json_annotation/json_annotation.dart';
part 'login_response.g.dart';

@JsonSerializable()
class LoginResponse {
  bool? success;
  String? status;
  String? token;
  User? user;

  LoginResponse({this.success, this.status, this.token, this.user});

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}
