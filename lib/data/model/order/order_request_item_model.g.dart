// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_request_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderRequestItemModel _$OrderRequestItemModelFromJson(
        Map<String, dynamic> json) =>
    OrderRequestItemModel(
      productId: json['productId'] as String,
      quantity: (json['quantity'] as num).toInt(),
      price: (json['price'] as num).toDouble(),
    );

Map<String, dynamic> _$OrderRequestItemModelToJson(
        OrderRequestItemModel instance) =>
    <String, dynamic>{
      'productId': instance.productId,
      'quantity': instance.quantity,
      'price': instance.price,
    };
