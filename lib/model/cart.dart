import 'package:artsy/model/products.dart';
import 'package:artsy/model/user.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:objectbox/objectbox.dart';
part 'cart.g.dart';

@Entity()
@JsonSerializable()
class Cart {
  @Id(assignable: true)
  int cId;

  @Unique()
  @Index()
  @JsonKey(name: "_id")
  String? id;
  User? user;
  Product? product;
  int? quantity;
  int? amount;

  Cart(
      {this.id,
      this.user,
      this.product,
      this.quantity,
      this.amount,
      this.cId = 0});

  factory Cart.fromJson(Map<String, dynamic> json) => _$CartFromJson(json);

  Map<String, dynamic> toJson() => _$CartToJson(this);
}
