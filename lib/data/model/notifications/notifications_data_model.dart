import 'package:json_annotation/json_annotation.dart';

part 'notifications_data_model.g.dart';

@JsonSerializable()
class NotificationsModel {
  final String title;
  final String message;
  final DateTime created;
  final String type;
  final String? userNotification;
  final String? userNotifications;
  final String id;

  NotificationsModel({
    required this.title,
    required this.message,
    required this.created,
    required this.type,
    this.userNotification,
    this.userNotifications,
    required this.id,
  });

  factory NotificationsModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationsModelFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationsModelToJson(this);
}
