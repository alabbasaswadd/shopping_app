import 'package:get/get.dart';
import 'package:shopping_app/data/model/products_model.dart';
import 'package:shopping_app/data/web_services/products_web_services.dart';

class Repository {
  final WebServices webServices;
  Repository(this.webServices);
  Future<List<ProductsModel>> getData() async {
    final products = await webServices.getData();
    return products.map((product) => ProductsModel.fromJson(product)).toList();
  }

  signUpRepository(Map<String, dynamic> data) async {
    try {
      final response = await webServices.signUpWebService(data);

      if (response != null && response.statusCode == 200) {
        return response;
      } else {
        print('فشل في التسجيل: ${response?.statusCode}');
        return null;
      }
    } catch (e) {
      print('خطأ في المستودع (Repository): $e');
      return null;
    }
  }

  loginRepository(Map<String, dynamic> data) async {
    try {
      final response = await webServices.loginWebServices(data);

      if (response != null && response.statusCode == 200) {
        return response;
      } else {
        print('فشل في التسجيل: ${response?.statusCode}');
        return null;
      }
    } catch (e) {
      print('خطأ في المستودع (Repository): $e');
      return null;
    }
  }
}
