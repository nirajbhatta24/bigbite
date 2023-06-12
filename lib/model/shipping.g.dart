// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shipping.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Address _$AddressFromJson(Map<String, dynamic> json) => Address(
      id: json['_id'] as String?,
      address: json['address'] as String?,
      city: json['city'] as String?,
      state: json['state'] as String?,
      aId: json['aId'] as int? ?? 0,
    );

Map<String, dynamic> _$AddressToJson(Address instance) => <String, dynamic>{
      'aId': instance.aId,
      '_id': instance.id,
      'address': instance.address,
      'city': instance.city,
      'state': instance.state,
    };
