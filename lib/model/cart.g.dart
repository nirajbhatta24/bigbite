// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Cart _$CartFromJson(Map<String, dynamic> json) => Cart(
      id: json['_id'] as String?,
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
      product: json['product'] == null
          ? null
          : Product.fromJson(json['product'] as Map<String, dynamic>),
      quantity: json['quantity'] as int?,
      amount: json['amount'] as int?,
      cId: json['cId'] as int? ?? 0,
    );

Map<String, dynamic> _$CartToJson(Cart instance) => <String, dynamic>{
      'cId': instance.cId,
      '_id': instance.id,
      'user': instance.user,
      'product': instance.product,
      'quantity': instance.quantity,
      'amount': instance.amount,
    };
