import 'package:bloc/bloc.dart';
import 'package:shopping_app/data/repository/auth_repository.dart';
import 'package:shopping_app/presentation/business_logic/cubit/auth/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository authRepository;

  AuthCubit(this.authRepository) : super(AuthInitial());

  Future<void> login(String email, String password) async {
    emit(AuthLoading());

    try {
      final user = await authRepository.login(email, password);
      emit(AuthAuthenticated(user));
    } catch (e) {
      emit(AuthError('فشل تسجيل الدخول: ${e.toString()}'));
    }
  }

  Future<void> signup(String email, String password, String name) async {
    emit(AuthLoading());

    try {
      final user = await authRepository.signup(email, password, name);
      emit(AuthSignUpSuccess());
    } catch (e) {
      emit(AuthError('فشل إنشاء الحساب: ${e.toString()}'));
    }
  }

  void logout() {
    authRepository.logout(); // ممكن تمسح التوكن من Hive أو SharedPreferences
    emit(AuthUnauthenticated());
  }

  void checkAuthStatus() {
    final user = authRepository.getSavedUser();
    if (user != null) {
      emit(AuthAuthenticated(user));
    } else {
      emit(AuthUnauthenticated());
    }
  }
}
