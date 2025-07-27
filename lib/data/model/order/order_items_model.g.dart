// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_items_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderItemsModel _$OrderItemsModelFromJson(Map<String, dynamic> json) =>
    OrderItemsModel(
      id: json['id'] as String?,
      productName: json['productName'] as String?,
      orderId: json['orderId'] as String?,
      productId: json['productId'] as String?,
      quantity: (json['quantity'] as num?)?.toInt(),
      price: (json['price'] as num?)?.toInt(),
    );

Map<String, dynamic> _$OrderItemsModelToJson(OrderItemsModel instance) =>
    <String, dynamic>{
      if (instance.id case final value?) 'id': value,
      if (instance.productName case final value?) 'productName': value,
      if (instance.orderId case final value?) 'orderId': value,
      if (instance.productId case final value?) 'productId': value,
      if (instance.quantity case final value?) 'quantity': value,
      if (instance.price case final value?) 'price': value,
    };
