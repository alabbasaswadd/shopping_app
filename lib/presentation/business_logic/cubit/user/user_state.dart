import 'package:shopping_app/data/model/user/user_data_model.dart';

abstract class UserState {}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserLoaded extends UserState {
  final UserDataModel user;

  UserLoaded(this.user);
}

class UserUpdated extends UserState {}

class UserDeleted extends UserState {}

class UserError extends UserState {
  final String message;

  UserError(this.message);
}
