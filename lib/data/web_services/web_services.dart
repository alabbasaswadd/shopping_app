import 'package:dio/dio.dart';
import 'package:shopping_app/core/constants/route.dart';
import 'package:shopping_app/data/model/user_model.dart';

class WebServices {
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      validateStatus: (status) {
        return status != null && status < 500;
      },
    ),
  );
  Future<List<dynamic>> getData() async {
    Response response = await dio.get('https://fakestoreapi.com/products');
    return response.data;
  }

  Future<Response?> signUpWebService(Map<String, dynamic> data) async {
    try {
      final response = await dio.post(
        "$baseUrl$signUp",
        data: data,
      );
      return response;
    } catch (e) {
      if (e is DioException) {
        print('📛 Dio Error Data: ${e.response?.data}');
      }
      print('Error during sign up: $e');
      return null;
    }
  }

  Future<Response?> loginWebServices(Map<String, dynamic> data) async {
    try {
      final response = await dio.post(
        "$baseUrl$login",
        data: data,
      );
      print('✅ تم الاتصال بالسيرفر: ${response.statusCode}');
      return response;
    } catch (e) {
      if (e is DioException) {
        print('📛 DioException: ${e.message}');
        print('📛 النوع: ${e.type}');
        print('📛 البيانات القادمة من السيرفر: ${e.response?.data}');
        print('📛 كود الحالة: ${e.response?.statusCode}');
      } else {
        print('📛 خطأ عام: $e');
      }
      return null;
    }
  }

  Future<Response?> getUserDataWebServices(String userId) async {
    try {
      final response = await dio.get(
        "$baseUrl/customer/1c991b31-334b-4fcf-70e3-08ddb0d9e9db",
      );
      return response;
    } catch (e) {
      if (e is DioException) {
        print('📛 DioException: ${e.message}');
        print('📛 البيانات القادمة من السيرفر: ${e.response?.data}');
        print('📛 كود الحالة: ${e.response?.statusCode}');
      } else {
        print('📛 خطأ عام: $e');
      }
      return null;
    }
  }

  Future<UserModel> getUserWebServices(String userId) async {
    final response = await dio.get('$baseUrl${getUserRoute(userId)}');
    print('Response data: ${response.data}');
    return UserModel.fromJson(response.data['data']);
  }

  Future<void> updateUserWebServices(String userId, UserModel user) async {
    await dio.put('$baseUrl${updateUserRoute(userId)}', data: user.toJson());
  }

  Future<void> deleteUserWebServices(String userId) async {
    await dio.delete('$baseUrl${deleteUserRoute(userId)}');
  }
}
