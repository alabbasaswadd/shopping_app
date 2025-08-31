// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notifications_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationsResponse _$NotificationsResponseFromJson(
        Map<String, dynamic> json) =>
    NotificationsResponse(
      succeeded: json['succeeded'] as bool,
      data: (json['data'] as List<dynamic>)
          .map((e) => NotificationsModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      errors: json['errors'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$NotificationsResponseToJson(
        NotificationsResponse instance) =>
    <String, dynamic>{
      'succeeded': instance.succeeded,
      'data': instance.data,
      'errors': instance.errors,
    };
