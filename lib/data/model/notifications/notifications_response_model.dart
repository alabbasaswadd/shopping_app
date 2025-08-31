import 'package:json_annotation/json_annotation.dart';
import 'package:shopping_app/data/model/notifications/notifications_data_model.dart';

part 'notifications_response_model.g.dart';

@JsonSerializable()
class NotificationsResponse {
  final bool succeeded;
  final List<NotificationsModel> data;
  final Map<String, dynamic> errors;

  NotificationsResponse({
    required this.succeeded,
    required this.data,
    required this.errors,
  });

  factory NotificationsResponse.fromJson(Map<String, dynamic> json) =>
      _$NotificationsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationsResponseToJson(this);
}
