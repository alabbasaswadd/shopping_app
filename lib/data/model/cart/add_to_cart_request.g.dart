// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_to_cart_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddToCartRequest _$AddToCartRequestFromJson(Map<String, dynamic> json) =>
    AddToCartRequest(
      shoppingCartId: json['shoppingCartId'] as String,
      productId: json['productId'] as String,
      quantity: (json['quantity'] as num).toInt(),
      shopId: json['shopId'] as String,
    );

Map<String, dynamic> _$AddToCartRequestToJson(AddToCartRequest instance) =>
    <String, dynamic>{
      'shoppingCartId': instance.shoppingCartId,
      'productId': instance.productId,
      'quantity': instance.quantity,
      'shopId': instance.shopId,
    };
