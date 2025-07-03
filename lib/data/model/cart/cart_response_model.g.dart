// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartResponseModel _$CartResponseModelFromJson(Map<String, dynamic> json) =>
    CartResponseModel(
      succeeded: json['succeeded'] as bool,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => CartDataModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      errors: json['errors'] == null
          ? null
          : ErrorModel.fromJson(json['errors'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CartResponseModelToJson(CartResponseModel instance) =>
    <String, dynamic>{
      'succeeded': instance.succeeded,
      'data': instance.data,
      'errors': instance.errors,
    };
