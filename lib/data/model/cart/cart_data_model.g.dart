// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartDataModel _$CartDataModelFromJson(Map<String, dynamic> json) =>
    CartDataModel(
      id: json['id'] as String,
      creationDate: json['creationDate'] as String,
      customerId: json['customerId'] as String,
      shoppingCartItems: (json['shoppingCartItems'] as List<dynamic>)
          .map(
              (e) => ShoppingCartItemsModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CartDataModelToJson(CartDataModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'creationDate': instance.creationDate,
      'customerId': instance.customerId,
      'shoppingCartItems': instance.shoppingCartItems,
    };
