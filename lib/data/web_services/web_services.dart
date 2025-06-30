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
    Response response = await dio.get("$baseUrl$getAllProducts",
        options: Options(headers: {
          "Authorization":
              "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJvdXNzYW1hbWFkZWw1QGdtYWlsLmNvbSIsImp0aSI6IjE5ZjNjODQ0LTJmYWEtNDRmNi05MDQ2LTc0Y2M1NGJlZGJlYyIsInVzZXJJZCI6IjAwMDAwMDAwLTAwMDAtMDAwMC0wMDAwLTAwMDAwMDAwMDAwMCIsImh0dHA6Ly9zY2hlbWFzLm1pY3Jvc29mdC5jb20vd3MvMjAwOC8wNi9pZGVudGl0eS9jbGFpbXMvcm9sZSI6IlVzZXIiLCJleHAiOjE3ODIxNjAzNzcsImlzcyI6Imh0dHBzOi8vbG9jYWxob3N0LzUyMjkiLCJhdWQiOiJNdWx0aVZlbmRvck1hcmtldHBsYWNlIn0.QGUE7erIy2bKbtBzou68UoJ83I1oETr5ZOaEOhxiYyw"
        }));
    return response.data['data'];
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
