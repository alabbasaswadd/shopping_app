// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shopping_cart_items_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShoppingCartItemsModel _$ShoppingCartItemsModelFromJson(
        Map<String, dynamic> json) =>
    ShoppingCartItemsModel(
      id: json['id'] as String?,
      shoppingCartId: json['shoppingCartId'] as String?,
      productId: json['productId'] as String?,
      productName: json['productName'] as String?,
      productImage: json['productImage'] as String?,
      productPrice: (json['productPrice'] as num?)?.toDouble(),
      shopId: json['shopId'] as String?,
      quantity: (json['quantity'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ShoppingCartItemsModelToJson(
        ShoppingCartItemsModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'shoppingCartId': instance.shoppingCartId,
      'productId': instance.productId,
      'productName': instance.productName,
      'productImage': instance.productImage,
      'productPrice': instance.productPrice,
      'shopId': instance.shopId,
      'quantity': instance.quantity,
    };
