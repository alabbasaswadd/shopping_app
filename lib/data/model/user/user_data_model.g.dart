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
      shoppingCartId: json['shoppingCartId'] as String?,
      dateOfBirth: json['dateOfBirth'] as String?,
      emailId: json['emailId'] as String?,
      phone: json['phone'] as String?,
      addressId: json['addressId'] as String?,
      email: json['email'] == null
          ? null
          : UserEmailModel.fromJson(json['email'] as Map<String, dynamic>),
      address: json['address'] == null
          ? null
          : UserAddressModel.fromJson(json['address'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserDataModelToJson(UserDataModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'shoppingCartId': instance.shoppingCartId,
      'dateOfBirth': instance.dateOfBirth,
      'emailId': instance.emailId,
      'phone': instance.phone,
      'addressId': instance.addressId,
      'email': instance.email,
      'address': instance.address,
    };
