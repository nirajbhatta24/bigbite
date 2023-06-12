// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Category _$CategoryFromJson(Map<String, dynamic> json) => Category(
      json['_id'] as String?,
      json['categoryName'] as String?,
      id: json['id'] as int? ?? 0,
    );

Map<String, dynamic> _$CategoryToJson(Category instance) => <String, dynamic>{
      'id': instance.id,
      '_id': instance.categoryId,
      'categoryName': instance.categoryName,
    };
