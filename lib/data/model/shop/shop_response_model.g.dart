// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shop_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShopResponseModel _$ShopResponseModelFromJson(Map<String, dynamic> json) =>
    ShopResponseModel(
      succeeded: json['succeeded'] as bool,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => ShopDataModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      errors: json['errors'] == null
          ? null
          : ErrorModel.fromJson(json['errors'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ShopResponseModelToJson(ShopResponseModel instance) =>
    <String, dynamic>{
      'succeeded': instance.succeeded,
      'data': instance.data,
      'errors': instance.errors,
    };
