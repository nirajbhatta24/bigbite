import 'package:artsy/model/user.dart';
import 'package:json_annotation/json_annotation.dart';
part 'profile_response.g.dart';

@JsonSerializable()
class ProfileResponse {
  bool? success;
  String? message;
  User? data;

  ProfileResponse({this.success, this.message, this.data});

  factory ProfileResponse.fromJson(Map<String, dynamic> json) =>
      _$ProfileResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileResponseToJson(this);
}