import 'package:bloc/bloc.dart';
import 'package:shopping_app/data/repository/products_repository.dart';
import 'package:shopping_app/data/web_services/products_web_services.dart';
import 'package:shopping_app/presentation/business_logic/cubit/auth/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final Repository repository = Repository(WebServices());

  AuthCubit() : super(AuthInitial());

  // Future<void> login(String email, String password) async {
  //   emit(AuthLoading());

  //   try {
  //     final user = await repository.login(email, password);
  //     emit(AuthAuthenticated(user));
  //   } catch (e) {
  //     emit(AuthError('فشل تسجيل الدخول: ${e.toString()}'));
  //   }
  // }

  Future<void> signup({
    required String firstName,
    required String lastName,
    required String birthDate,
    required int gender,
    required String email,
    required String phone,
    required String password,
    required String address,
    required String city,
    required String street,
    required String floor,
    required String apartment,
    required bool defaultAddress,
  }) async {
    emit(AuthLoading());

    try {
      final response = await repository.signUpRepository({
        'firstName': firstName,
        'lastName': lastName,
        'birthDate': birthDate,
        'gender': gender,
        'email': email,
        'phone': phone,
        'password': password,
        'address': {
          "city": city,
          "street": street,
          "floor": floor,
          "apartment": apartment,
          "defaultAddress": defaultAddress,
        }
      });

      if (response) {
        emit(AuthSignUpSuccess());
      } else {
        emit(AuthError('فشل إنشاء الحساب'));
      }
    } catch (e) {
      emit(AuthError('حدث خطأ: ${e.toString()}'));
    }
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    emit(AuthLoading());
    try {
      final response = await repository
          .loginRepository({"email": email, "password": password});
      if (response) {
        emit(AuthSignUpSuccess());
      } else {
        emit(AuthError('فشل إنشاء الحساب'));
      }
    } catch (e) {
      emit(AuthError('حدث خطأ: ${e.toString()}'));
    }
  }
  // void logout() {
  //   authRepository.logout(); // ممكن تمسح التوكن من Hive أو SharedPreferences
  //   emit(AuthUnauthenticated());
  // }

  // void checkAuthStatus() {
  //   final user = authRepository.getSavedUser();
  //   if (user != null) {
  //     emit(AuthAuthenticated(user));
  //   } else {
  //     emit(AuthUnauthenticated());
  //   }
  // }
}
