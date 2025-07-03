// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_address_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserAddressModel _$UserAddressModelFromJson(Map<String, dynamic> json) =>
    UserAddressModel(
      city: json['city'] as String?,
      street: json['street'] as String?,
      floor: json['floor'] as String?,
      apartment: json['apartment'] as String?,
      defaultAddress: json['defaultAddress'] as bool?,
    );

Map<String, dynamic> _$UserAddressModelToJson(UserAddressModel instance) =>
    <String, dynamic>{
      'city': instance.city,
      'street': instance.street,
      'floor': instance.floor,
      'apartment': instance.apartment,
      'defaultAddress': instance.defaultAddress,
    };
