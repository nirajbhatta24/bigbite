// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Orders _$OrdersFromJson(Map<String, dynamic> json) => Orders(
      id: json['_id'] as String?,
      products: (json['products'] as List<dynamic>?)
          ?.map((e) => Product.fromJson(e as Map<String, dynamic>))
          .toList(),
      quantity:
          (json['quantity'] as List<dynamic>?)?.map((e) => e as int).toList(),
      amount: json['amount'] as int?,
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
      status: json['status'] as String?,
      oId: json['oId'] as int? ?? 0,
    );

Map<String, dynamic> _$OrdersToJson(Orders instance) => <String, dynamic>{
      'oId': instance.oId,
      '_id': instance.id,
      'products': instance.products,
      'quantity': instance.quantity,
      'amount': instance.amount,
      'status': instance.status,
      'user': instance.user,
    };
