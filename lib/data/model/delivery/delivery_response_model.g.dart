// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delivery_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeliveryResponseModel _$DeliveryResponseModelFromJson(
        Map<String, dynamic> json) =>
    DeliveryResponseModel(
      succeeded: json['succeeded'] as bool,
      data: (json['data'] as List<dynamic>)
          .map((e) => DeliveryDataModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      errors: json['errors'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$DeliveryResponseModelToJson(
        DeliveryResponseModel instance) =>
    <String, dynamic>{
      'succeeded': instance.succeeded,
      'data': instance.data,
      'errors': instance.errors,
    };
