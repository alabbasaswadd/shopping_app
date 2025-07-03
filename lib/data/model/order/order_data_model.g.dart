// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderDataModel _$OrderDataModelFromJson(Map<String, dynamic> json) =>
    OrderDataModel(
      id: json['id'] as String?,
      customerId: json['customerId'] as String?,
      shopId: json['shopId'] as String?,
      orderDate: json['orderDate'] as String?,
      totalAmount: (json['totalAmount'] as num?)?.toInt(),
      orderState: json['orderState'] as String?,
      orderItems: (json['orderItems'] as List<dynamic>?)
          ?.map((e) => OrderItemsModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OrderDataModelToJson(OrderDataModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'customerId': instance.customerId,
      'shopId': instance.shopId,
      'orderDate': instance.orderDate,
      'totalAmount': instance.totalAmount,
      'orderState': instance.orderState,
      'orderItems': instance.orderItems,
    };
