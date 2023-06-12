// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'products.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      productId: json['_id'] as String?,
      name: json['name'] as String?,
      price: json['price'] as String?,
      image: json['image'] as String?,
      description: json['description'] as String?,
      category: json['category'] == null
          ? null
          : Category.fromJson(json['category'] as Map<String, dynamic>),
      pid: json['pid'] as int? ?? 0,
    );

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'pid': instance.pid,
      '_id': instance.productId,
      'name': instance.name,
      'price': instance.price,
      'image': instance.image,
      'description': instance.description,
      'category': instance.category,
    };
