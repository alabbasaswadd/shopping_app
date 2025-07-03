// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_email_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserEmailModel _$UserEmailModelFromJson(Map<String, dynamic> json) =>
    UserEmailModel(
      userName: json['userName'] as String?,
      password: json['password'] as String?,
      customerId: json['customerId'] as String?,
      shopId: json['shopId'] as String?,
    );

Map<String, dynamic> _$UserEmailModelToJson(UserEmailModel instance) =>
    <String, dynamic>{
      'userName': instance.userName,
      'password': instance.password,
      'shopId': instance.shopId,
      'customerId': instance.customerId,
    };
