// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notifications_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationsModel _$NotificationsModelFromJson(Map<String, dynamic> json) =>
    NotificationsModel(
      title: json['title'] as String,
      message: json['message'] as String,
      created: DateTime.parse(json['created'] as String),
      type: json['type'] as String,
      userNotification: json['userNotification'] as String?,
      userNotifications: json['userNotifications'] as String?,
      id: json['id'] as String,
    );

Map<String, dynamic> _$NotificationsModelToJson(NotificationsModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'message': instance.message,
      'created': instance.created.toIso8601String(),
      'type': instance.type,
      'userNotification': instance.userNotification,
      'userNotifications': instance.userNotifications,
      'id': instance.id,
    };
