import 'package:artsy/model/category.dart';
import 'package:json_annotation/json_annotation.dart';
part 'category_response.g.dart';

@JsonSerializable()
class CategoryResponse {
  bool? success;
  String? message;
  List<Category>? data;

  CategoryResponse({this.success, this.message, this.data});

  factory CategoryResponse.fromJson(Map<String, dynamic> json) =>
      _$CategoryResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryResponseToJson(this);
}

