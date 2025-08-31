// import 'package:freezed_annotation/freezed_annotation.dart';

// @freezed
// class NotificationsState with _$NotificationsState {
//   const factory NotificationsState.initial() = _Initial;
// }

import 'package:shopping_app/data/model/notifications/notifications_data_model.dart';

abstract class NotificationsState {}

class NotificationsLoading extends NotificationsState {}

class NotificationsEmpty extends NotificationsState {}

class NotificationsLoaded extends NotificationsState {
  final List<NotificationsModel> notifications;
  NotificationsLoaded(this.notifications);
}

class NotificationsError extends NotificationsState {
  final String error;
  NotificationsError(this.error);
}
