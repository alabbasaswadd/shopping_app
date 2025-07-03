// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDataModel _$UserDataModelFromJson(Map<String, dynamic> json) =>
    UserDataModel(
      id: json['id'] as String?,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      birthDate: json['birthDate'] as String?,
      shoppingCartId: json['shoppingCartId'] as String?,
      gender: (json['gender'] as num?)?.toInt(),
      email: json['email'] == null
          ? null
          : UserEmailModel.fromJson(json['email'] as Map<String, dynamic>),
      phone: json['phone'] as String?,
      password: json['password'] as String?,
      address: json['address'] == null
          ? null
          : UserAddressModel.fromJson(json['address'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserDataModelToJson(UserDataModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'birthDate': instance.birthDate,
      'shoppingCartId': instance.shoppingCartId,
      'gender': instance.gender,
      'email': instance.email,
      'phone': instance.phone,
      'password': instance.password,
      'address': instance.address,
    };
