// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterResponseModel _$RegisterResponseModelFromJson(
        Map<String, dynamic> json) =>
    RegisterResponseModel(
      succeeded: json['succeeded'] as bool,
      data: json['data'] as Map<String, dynamic>?,
      errors: ErrorModel.fromJson(json['errors'] as Map<String, dynamic>),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$RegisterResponseModelToJson(
        RegisterResponseModel instance) =>
    <String, dynamic>{
      'succeeded': instance.succeeded,
      'data': instance.data,
      'errors': instance.errors.toJson(),
      'message': instance.message,
    };
