import 'package:artsy/model/cart.dart';
import 'package:artsy/model/products.dart';
import 'package:artsy/model/shipping.dart';
import 'package:artsy/model/user.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:objectbox/objectbox.dart';
part 'order.g.dart';

@Entity()
@JsonSerializable()
class Orders {
  @Id(assignable: true)
  int oId;

  @Unique()
  @Index()
  @JsonKey(name: "_id")
  String? id;
  List<Product>? products;
  List<int>? quantity;
  int? amount;
  String? status;
  User? user;

  Orders({this.id, this.products,this.quantity,this.amount,this.user, this.status, this.oId = 0});
  factory Orders.fromJson(Map<String, dynamic> json) => _$OrdersFromJson(json);

  Map<String, dynamic> toJson() => _$OrdersToJson(this);
}
