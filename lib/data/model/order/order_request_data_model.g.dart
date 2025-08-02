// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_request_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderRequestDataModel _$OrderRequestDataModelFromJson(
        Map<String, dynamic> json) =>
    OrderRequestDataModel(
      customerId: json['customerId'] as String,
      shopId: json['shopId'] as String,
      deliveryCompanyId: json['deliveryCompanyId'] as String,
      addressId: json['addressId'] as String,
      orderDate: DateTime.parse(json['orderDate'] as String),
      totalAmount: (json['totalAmount'] as num).toDouble(),
      noteDelivery: json['noteDelivery'] as String,
      shippedDate: DateTime.parse(json['shippedDate'] as String),
      orderState: (json['orderState'] as num).toInt(),
      orderItems: (json['orderItems'] as List<dynamic>)
          .map((e) => OrderRequestItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OrderRequestDataModelToJson(
        OrderRequestDataModel instance) =>
    <String, dynamic>{
      'customerId': instance.customerId,
      'shopId': instance.shopId,
      'deliveryCompanyId': instance.deliveryCompanyId,
      'addressId': instance.addressId,
      'orderDate': instance.orderDate.toIso8601String(),
      'totalAmount': instance.totalAmount,
      'noteDelivery': instance.noteDelivery,
      'shippedDate': instance.shippedDate.toIso8601String(),
      'orderState': instance.orderState,
      'orderItems': instance.orderItems.map((e) => e.toJson()).toList(),
    };
