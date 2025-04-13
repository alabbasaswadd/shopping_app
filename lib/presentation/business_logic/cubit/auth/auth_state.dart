import 'package:shopping_app/data/model/user_model.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthAuthenticated extends AuthState {
  final UserModel user;
  AuthAuthenticated(this.user);
}

class AuthUnauthenticated extends AuthState {}

class AuthError extends AuthState {
  final String message;
  AuthError(this.message);
}

class AuthSignUpSuccess extends AuthState {}

class AuthLogoutSuccess extends AuthState {}

class AuthPasswordResetSent extends AuthState {}
