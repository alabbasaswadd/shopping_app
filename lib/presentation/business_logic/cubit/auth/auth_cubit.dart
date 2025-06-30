import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:shopping_app/core/constants/functions.dart';
import 'package:shopping_app/data/model/auth_data_model.dart';
import 'package:shopping_app/data/model/response_model.dart';
import 'package:shopping_app/data/model/user_model.dart';
import 'package:shopping_app/data/repository/products_repository.dart';
import 'package:shopping_app/data/web_services/web_services.dart';
import 'package:shopping_app/presentation/business_logic/cubit/auth/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final Repository repository = Repository(WebServices());

  AuthCubit() : super(AuthInit());

  Future<void> signup({
    required String firstName,
    required String lastName,
    required String birthDate,
    required int gender,
    required String email,
    required String phone,
    required String password,
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

      if (response != null && response.data != null) {
        try {
          final authResponse = AuthResponse.fromJson(response.data);
          print("✅ succeeded: ${authResponse.succeeded}");
          if (authResponse.succeeded == true) {
            emit(AuthSignUpSuccess());
            print("✅ تم التسجيل بنجاح");
            print("🧾 Response Data: ${response.data}");
          } else {
            final errorMessage = _extractFirstError(authResponse.errors) ??
                authResponse.message ??
                "حدث خطأ أثناء التسجيل";
            emit(AuthError(errorMessage));
          }
        } catch (e) {
          print("🧾 Response Data: ${response.data}");
          print("❌ Error parsing response: $e");
          emit(AuthError("فشل في تحليل استجابة السيرفر"));
        }
      } else {
        emit(AuthError("فشل الاتصال بالسيرفر"));
      }
    } catch (e) {
      print("❌ Exception: $e");
      if (e is DioException) {
        final errorData = e.response?.data;
        final message = errorData?['message']?.toString() ??
            _extractFirstError(errorData?['errors']) ??
            "حدث خطأ أثناء الاتصال بالسيرفر";
        emit(AuthError(message));
      } else {
        emit(AuthError("حدث خطأ غير متوقع: ${e.toString()}"));
      }
    }
  }

  String? _extractFirstError(dynamic errors) {
    if (errors is Map<String, dynamic>) {
      for (var value in errors.values) {
        if (value is List && value.isNotEmpty) {
          return value.first.toString();
        }
      }
    }
    return null;
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    emit(AuthLoading());

    try {
      final response = await repository.loginRepository({
        "email": email,
        "password": password,
      });

      if (response != null) {
        final authResponse = AuthResponse.fromJson(response.data);

        if (authResponse.succeeded == true && authResponse.data != null) {
          // ✅ حفظ بيانات تسجيل الدخول البسيطة (token - userName - customerId)
          final token = authResponse.data!.token;
          final userName = authResponse.data!.userName;
          final customerId = authResponse.data!.customerId;

          await UserPreferencesService.saveUser({
            "token": token,
            "userName": userName,
            "customerId": customerId,
          });

          // ✅ جلب بيانات المستخدم الشخصية من API باستخدام customerId
          final userModel = await repository.getUserRepository(customerId!);

          // تحديث الجلسة ببيانات المستخدم الكاملة
          await UserSession.updateUser(userModel);

          emit(AuthAuthenticated());
        } else {
          // ⛔ استخراج أول رسالة خطأ من errors
          String errorMessage = "البيانات المدخلة غير صحيحة";
          if (authResponse.errors.isNotEmpty) {
            final firstKey = authResponse.errors.keys.first;
            final errorList = authResponse.errors[firstKey];
            if (errorList is List && errorList.isNotEmpty) {
              errorMessage = errorList.first.toString();
            }
          }
          emit(AuthError(errorMessage));
        }
      } else {
        emit(AuthError("فشل الاتصال بالسيرفر"));
      }
    } catch (e) {
      if (e is DioException) {
        final errorData = e.response?.data;
        final serverMessage =
            errorData is Map<String, dynamic> && errorData['message'] != null
                ? errorData['message'].toString()
                : "خطأ في الاتصال بالسيرفر";
        emit(AuthError(serverMessage));
      } else {
        emit(AuthError("حدث خطأ غير متوقع: ${e.toString()}"));
      }
    }
  }

  Future<void> getUserData() async {
    try {
      final userId = await UserPreferencesService.getUserValue('customerId');

      if (userId != null) {
        final response = await repository.getUserDataRepository(userId);

        if (response != null && response.data != null) {
          final Map<String, dynamic> json = response.data;
          final user = UserModel.fromJson(json);

          // ✅ تخزين بيانات المستخدم داخل SharedPreferences
          await UserPreferencesService.saveUser(user.toJson());
          print("🧾 User Data: ${user.toJson()}");
        } else {
          emit(AuthError("فشل في استرجاع بيانات المستخدم"));
        }
      } else {
        emit(AuthError("لم يتم العثور على معرف المستخدم"));
      }
    } catch (e) {
      print("❌ Exception: $e");
      emit(AuthError("حدث خطأ أثناء استرجاع بيانات المستخدم"));
    }
  }

  Future<void> logout() async {
    await UserPreferencesService.clearUser();
    emit(AuthInit());
  }
}
