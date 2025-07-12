
abstract class AuthState {}

class AuthInit extends AuthState {}
class AuthLoading extends AuthState {}

class AuthAuthenticated extends AuthState {
  AuthAuthenticated();
}

class AuthUnauthenticated extends AuthState {}

class AuthError extends AuthState {
  final String message;
  AuthError(this.message);
}

class AuthSignUpSuccess extends AuthState {}

class AuthLogoutSuccess extends AuthState {}

class AuthPasswordResetSent extends AuthState {}
