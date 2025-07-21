// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'offer_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OfferDataModel _$OfferDataModelFromJson(Map<String, dynamic> json) =>
    OfferDataModel(
      shopId: json['shopId'] as String?,
      productId: json['productId'] as String?,
      imageUrl: json['imageUrl'] as String?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      discountPercentage: (json['discountPercentage'] as num?)?.toInt(),
      newPrice: json['newPrice'] as num?,
      startDate: json['startDate'] == null
          ? null
          : DateTime.parse(json['startDate'] as String),
      endDate: json['endDate'] == null
          ? null
          : DateTime.parse(json['endDate'] as String),
      shop: json['shop'] == null
          ? null
          : ShopDataModel.fromJson(json['shop'] as Map<String, dynamic>),
      product: json['product'] == null
          ? null
          : ProductDataModel.fromJson(json['product'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OfferDataModelToJson(OfferDataModel instance) =>
    <String, dynamic>{
      'shopId': instance.shopId,
      'productId': instance.productId,
      'imageUrl': instance.imageUrl,
      'name': instance.name,
      'description': instance.description,
      'discountPercentage': instance.discountPercentage,
      'newPrice': instance.newPrice,
      'startDate': instance.startDate?.toIso8601String(),
      'endDate': instance.endDate?.toIso8601String(),
      'shop': instance.shop?.toJson(),
      'product': instance.product?.toJson(),
    };
