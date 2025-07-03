// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderResponseModel _$OrderResponseModelFromJson(Map<String, dynamic> json) =>
    OrderResponseModel(
      succeeded: json['succeeded'] as bool,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => OrderDataModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      errors: json['errors'] == null
          ? null
          : ErrorModel.fromJson(json['errors'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OrderResponseModelToJson(OrderResponseModel instance) =>
    <String, dynamic>{
      'succeeded': instance.succeeded,
      'data': instance.data,
      'errors': instance.errors,
    };
