// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shop_email_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShopEmailModel _$ShopEmailModelFromJson(Map<String, dynamic> json) =>
    ShopEmailModel(
      shopId: json['shopId'] as String?,
      customerId: json['customerId'] as String?,
      deliveryCompanyId: json['deliveryCompanyId'] as String?,
      userName: json['userName'] as String?,
      password: json['password'] as String?,
    );

Map<String, dynamic> _$ShopEmailModelToJson(ShopEmailModel instance) =>
    <String, dynamic>{
      'shopId': instance.shopId,
      'customerId': instance.customerId,
      'deliveryCompanyId': instance.deliveryCompanyId,
      'userName': instance.userName,
      'password': instance.password,
    };
