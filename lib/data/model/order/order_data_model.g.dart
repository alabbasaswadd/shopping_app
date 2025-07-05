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
      // if (instance.id case final value?) 'id': value,
      if (instance.customerId case final value?) 'customerId': value,
      if (instance.shopId case final value?) 'shopId': value,
      if (instance.orderDate case final value?) 'orderDate': value,
      if (instance.totalAmount case final value?) 'totalAmount': value,
      if (instance.orderState case final value?) 'orderState': value,
      if (instance.orderItems case final value?) 'orderItems': value,
    };
