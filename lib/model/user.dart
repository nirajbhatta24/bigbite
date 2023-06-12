//flutter pub run build_runner build  --delete-conflicting-outputs
import 'package:objectbox/objectbox.dart';
import 'package:artsy/model/shipping.dart';
import 'package:json_annotation/json_annotation.dart';
part 'user.g.dart';

@Entity()
@JsonSerializable()
class User {
  @Id(assignable: true)
  int uid;

  @Unique()
  @Index()
  @JsonKey(name: '_id')
  String? userID;
  String? fname;
  String? lname;
  String? image;
  String? username;
  String? password;
  String? email;
  String? role;
  Address? address;
  bool? isFormFilled;

  User(
      {this.uid = 0,
      this.userID,
      this.fname,
      this.lname,
      this.image,
      this.username,
      this.password,
      this.role,
      this.address,
      this.email,
      this.isFormFilled=false});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
