import 'package:json_annotation/json_annotation.dart';
import 'package:artsy/model/order.dart';
part 'order_response.g.dart';

@JsonSerializable()
class OrderResponse {
  String? message;
  bool? success;
  List<Orders>? data;

  OrderResponse({this.success, this.message, this.data});

  factory OrderResponse.fromJson(Map<String, dynamic> json) =>
      _$OrderResponseFromJson(json);

  Map<String, dynamic> toJson() => _$OrderResponseToJson(this);
}
