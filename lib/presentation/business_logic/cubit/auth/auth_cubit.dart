import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:shopping_app/core/api/errors/error_model.dart';
import 'package:shopping_app/core/constants/functions.dart';
import 'package:shopping_app/data/model/login/login_data_model.dart';
import 'package:shopping_app/data/model/login/login_response_model.dart';
import 'package:shopping_app/data/register/register_model.dart';
import 'package:shopping_app/data/model/user/user_data_model.dart';
import 'package:shopping_app/data/repository/repository.dart';
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
      if (response.data != null) {
        try {
          final authResponse = RegisterResponseModel.fromJson(response.data);
          if (authResponse.succeeded == true) {
            emit(AuthSignUpSuccess());
          } else {
            final errorMessage = _extractFirstError(authResponse.errors) ??
                authResponse.message ??
                "حدث خطأ أثناء التسجيل";
            emit(AuthError(errorMessage));
          }
        } catch (e) {
          emit(AuthError("فشل في تحليل استجابة السيرفر"));
        }
      } else {
        emit(AuthError("فشل الاتصال بالسيرفر"));
      }
    } catch (e) {
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

  Future<void> login({required String email, required String password}) async {
    emit(AuthLoading());

    try {
      final response = await repository.loginRepository(email, password);

      if (response.statusCode == 200 &&
          response.data != null &&
          response.data['succeeded'] == true) {
        final jsonData = response.data;
        final loginData = LoginDataModel.fromJson(jsonData['data']);

        final loginResponse = LoginResponseModel.fromJson(jsonData);

        if (loginResponse.succeeded == true && loginResponse.data != null) {
          final token = loginData.token;
          final customerId = loginData.customerId;
          await UserPreferencesService.saveToken(token ?? "");
          final responseDataModel =
              await repository.getUserRepository(customerId ?? "");
          final userModel =
              UserDataModel.fromJson(responseDataModel.data['data']);
          // var shopping = userModel.data['data'];

          await UserSession.updateUser(userModel);
          emit(AuthAuthenticated());
        } else {
          String errorMessage = "حدث خطأ غير معروف";

          if (loginResponse.errors != null &&
              loginResponse.errors!.errors != null &&
              loginResponse.errors!.errors!.isNotEmpty) {
            final firstKey = loginResponse.errors!.errors!.keys.first;
            final errorList = loginResponse.errors!.errors![firstKey];
            if (errorList != null && errorList.isNotEmpty) {
              errorMessage = errorList.first;
            }
          }
          emit(AuthError(errorMessage));
        }
      } else {
        emit(AuthError("فشل الاتصال بالسيرفر."));
      }
    } catch (e) {
      if (e is DioException) {
        try {
          final errorData = e.response?.data;
          if (errorData != null && errorData is Map<String, dynamic>) {
            final errorModel = ErrorModel.fromJson(errorData);

            // ✅ استخراج رسالة الخطأ من ErrorModel
            String errorMessage =
                errorModel.message ?? "خطأ في الاتصال بالسيرفر";

            if (errorModel.errors != null && errorModel.errors!.isNotEmpty) {
              final firstKey = errorModel.errors!.keys.first;
              final errorList = errorModel.errors![firstKey];
              if (errorList != null && errorList.isNotEmpty) {
                errorMessage = errorList.first;
              }
            }

            emit(AuthError(errorMessage));
          } else {
            emit(AuthError("فشل في قراءة رسالة الخطأ من السيرفر"));
          }
        } catch (_) {
          emit(AuthError("خطأ غير متوقع أثناء تحليل رسالة الخطأ"));
        }
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

        if (response.data != null) {
          final Map<String, dynamic> json = response.data;
          final user = UserDataModel.fromJson(json);

          // ✅ تخزين بيانات المستخدم داخل SharedPreferences
          await UserPreferencesService.saveUser(user.toJson());
        } else {
          emit(AuthError("فشل في استرجاع بيانات المستخدم"));
        }
      } else {
        emit(AuthError("لم يتم العثور على معرف المستخدم"));
      }
    } catch (e) {
      emit(AuthError("حدث خطأ أثناء استرجاع بيانات المستخدم"));
    }
  }

  Future<void> logout() async {
    await UserPreferencesService.clearUser();
    emit(AuthInit());
  }
}
