// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      birthDate: json['birthDate'] as String,
      gender: (json['gender'] as num).toInt(),
      email: json['email'] as String,
      phone: json['phone'] as String,
      password: json['password'] as String,
      address: AddressModel.fromJson(json['address'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'birthDate': instance.birthDate,
      'gender': instance.gender,
      'email': instance.email,
      'phone': instance.phone,
      'password': instance.password,
      'address': instance.address,
    };

AddressModel _$AddressModelFromJson(Map<String, dynamic> json) => AddressModel(
      city: json['city'] as String,
      street: json['street'] as String,
      floor: json['floor'] as String,
      apartment: json['apartment'] as String,
      defaultAddress: json['defaultAddress'] as bool,
    );

Map<String, dynamic> _$AddressModelToJson(AddressModel instance) =>
    <String, dynamic>{
      'city': instance.city,
      'street': instance.street,
      'floor': instance.floor,
      'apartment': instance.apartment,
      'defaultAddress': instance.defaultAddress,
    };
