import 'package:artsy/model/category.dart';
import 'package:artsy/model/user.dart';
import 'package:objectbox/objectbox.dart';
import 'package:json_annotation/json_annotation.dart';
part 'products.g.dart';

@Entity()
@JsonSerializable()
class Product {
  @Id(assignable: true)
  int pid;

  @Unique()
  @Index()
  @JsonKey(name: '_id')
  String? productId;
  String? name;
  String? price;
  String? image;
  String? description;
  Category? category;

  // final categories = ToOne<Category>();
  Product({
    this.productId,
    this.name,
    this.price,
    this.image,
    this.description,
    this.category,
    this.pid = 0,
  });

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);
}
