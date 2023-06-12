import 'package:json_annotation/json_annotation.dart';
import 'package:objectbox/objectbox.dart';
part 'shipping.g.dart';

@Entity()
@JsonSerializable()
class Address {
  @Id(assignable: true)
  int aId;

  @Unique()
  @Index()
  @JsonKey(name: "_id")
  String? id;
  String? address;
  String? city;
  String? state;
 
  Address(
      {this.id,
      this.address,
      this.city,
      this.state,
      this.aId = 0});

  factory Address.fromJson(Map<String, dynamic> json) => _$AddressFromJson(json);

  Map<String, dynamic> toJson() => _$AddressToJson(this);
}
