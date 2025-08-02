// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delivery_email_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeliveryEmailModel _$DeliveryEmailModelFromJson(Map<String, dynamic> json) =>
    DeliveryEmailModel(
      shopId: json['shopId'] as String?,
      customerId: json['customerId'] as String?,
      deliveryCompanyId: json['deliveryCompanyId'] as String?,
      userName: json['userName'] as String?,
      password: json['password'] as String?,
    );

Map<String, dynamic> _$DeliveryEmailModelToJson(DeliveryEmailModel instance) =>
    <String, dynamic>{
      'shopId': instance.shopId,
      'customerId': instance.customerId,
      'deliveryCompanyId': instance.deliveryCompanyId,
      'userName': instance.userName,
      'password': instance.password,
    };
