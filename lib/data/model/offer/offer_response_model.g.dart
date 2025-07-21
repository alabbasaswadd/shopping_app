// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'offer_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OfferResponseModel _$OfferResponseModelFromJson(Map<String, dynamic> json) =>
    OfferResponseModel(
      succeeded: json['succeeded'] as bool,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => OfferDataModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      errors: json['errors'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$OfferResponseModelToJson(OfferResponseModel instance) =>
    <String, dynamic>{
      'succeeded': instance.succeeded,
      'data': instance.data?.map((e) => e.toJson()).toList(),
      'errors': instance.errors,
    };
