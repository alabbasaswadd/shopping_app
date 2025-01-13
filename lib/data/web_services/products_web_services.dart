import 'package:dio/dio.dart';
class ProductsWebServices {
  Dio dio = Dio();
  Future<List<dynamic>> getData() async {
    Response response = await dio.get('https://fakestoreapi.com/products');
    return response.data;
  }
}
