import 'package:artsy/model/shipping.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:artsy/model/cart.dart';
part 'address_response.g.dart';

@JsonSerializable()
class AddressResponse {
  String? message;
  bool? success;
  List<Address>? data;

  AddressResponse({this.success, this.message, this.data});

  factory AddressResponse.fromJson(Map<String, dynamic> json) =>
      _$AddressResponseFromJson(json);
  
  Map<String, dynamic> toJson() => _$AddressResponseToJson(this);
}