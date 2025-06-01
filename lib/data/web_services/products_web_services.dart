import 'package:dio/dio.dart';
import 'package:shopping_app/core/constants/route.dart';

class WebServices {
  Dio dio = Dio();
  Future<List<dynamic>> getData() async {
    Response response = await dio.get('https://fakestoreapi.com/products');
    return response.data;
  }

  Future<Response?> signUpWebService(Map<String, dynamic> data) async {
    try {
      final response = await dio.post(
        "$baseUrl$signUp",
        data: data,
        options: Options(headers: {
          'Content-Type': 'application/json',
        }),
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
        options: Options(headers: {
          'Content-Type': 'application/json',
        }),
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
}
