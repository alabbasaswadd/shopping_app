// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductDataModel _$ProductDataModelFromJson(Map<String, dynamic> json) =>
    ProductDataModel(
      id: json['id'] as String?,
      name: json['name'] as String?,
      price: (json['price'] as num?)?.toInt(),
      image: json['image'] as String?,
      categoryId: json['categoryId'] as String?,
      currency: json['currency'] as String?,
      shopId: json['shopId'] as String?,
      shope: json['shope'] as String?,
      description: json['description'] as String?,
      creationDate: json['creationDate'] as String?,
      category: json['category'] == null
          ? null
          : CategoryDataModel.fromJson(
              json['category'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ProductDataModelToJson(ProductDataModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'price': instance.price,
      'image': instance.image,
      'categoryId': instance.categoryId,
      'currency': instance.currency,
      'shopId': instance.shopId,
      'description': instance.description,
      'creationDate': instance.creationDate,
      'shope': instance.shope,
      'category': instance.category,
    };
