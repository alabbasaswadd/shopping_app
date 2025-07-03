// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryResponseModel _$CategoryResponseModelFromJson(
        Map<String, dynamic> json) =>
    CategoryResponseModel(
      succeeded: json['succeeded'] as bool,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => CategoryDataModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      errors: json['errors'] == null
          ? null
          : ErrorModel.fromJson(json['errors'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CategoryResponseModelToJson(
        CategoryResponseModel instance) =>
    <String, dynamic>{
      'succeeded': instance.succeeded,
      'data': instance.data,
      'errors': instance.errors,
    };
