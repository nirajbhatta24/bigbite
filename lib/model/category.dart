import 'package:json_annotation/json_annotation.dart';
import 'package:objectbox/objectbox.dart';

part 'category.g.dart';
//flutter pub run build_runner build  --delete-conflicting-outputs

@JsonSerializable()
@Entity()
class Category {
  @Id(assignable: true)
  int id;

  @Unique()
  @JsonKey(name: '_id')
  String? categoryId;
  String? categoryName;

  // @Backlink()
  // final product = ToMany<Product>();

  Category(this.categoryId, this.categoryName, {this.id = 0});

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}
