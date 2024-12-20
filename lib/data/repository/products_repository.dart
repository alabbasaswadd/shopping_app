import 'package:dio/dio.dart';
import 'package:shopping_app/data/model/products_model.dart';

class ProductsRepository {
  Dio dio = Dio();

  Future<List<ProductsModel>> getData() async {
    Response response = await dio.get('https://fakestoreapi.com/products');
    if (response.statusCode == 200) {
      List<dynamic> productsJson = response.data;
      print(productsJson);
      return productsJson.map((json) => ProductsModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch products: ${response.statusCode}');
    }
  }
}
