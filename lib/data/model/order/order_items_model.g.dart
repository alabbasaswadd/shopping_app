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
      'id': instance.id,
      'productName': instance.productName,
      'orderId': instance.orderId,
      'productId': instance.productId,
      'quantity': instance.quantity,
      'price': instance.price,
    };
