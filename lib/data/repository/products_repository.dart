import 'package:dio/dio.dart';
import 'package:shopping_app/data/model/category/category_data_model.dart';
import 'package:shopping_app/data/model/products/product_data_model.dart';
import 'package:shopping_app/data/model/shop/shop_data_model.dart';
import 'package:shopping_app/data/model/user/user_data_model.dart';
import 'package:shopping_app/data/web_services/web_services.dart';

class Repository {
  final WebServices webServices;
  Repository(this.webServices);
  Future<List<ProductDataModel>> getData() async {
    final products = await webServices.getData();
    return products
        .map((product) => ProductDataModel.fromJson(product))
        .toList();
  }

  signUpRepository(Map<String, dynamic> data) async {
    try {
      final response = await webServices.signUpWebService(data);
      return response;
    } catch (e) {
      print('خطأ في المستودع (Repository): $e');
      return null;
    }
  }

  Future<Response?> loginRepository(Map<String, dynamic> data) async {
    try {
      final Response? response = await webServices.loginWebServices(data);
      return response;
    } catch (e) {
      print('خطأ في المستودع (Repository): $e');
      return null;
    }
  }

  Future<Response?> getUserDataRepository(String userId) async {
    try {
      final Response? response =
          await webServices.getUserDataWebServices(userId);
      return response;
    } catch (e) {
      print('خطأ في المستودع (Repository): $e');
      return null;
    }
  }

  Future<UserDataModel> getUserRepository(String userId) {
    return webServices.getUserWebServices(userId);
  }

  Future<void> updateUserRepository(String userId, UserDataModel user) {
    return webServices.updateUserWebServices(userId, user);
  }

  Future<void> deleteUserRepository(String userId) {
    return webServices.deleteUserWebServices(userId);
  }

  Future<List<ShopDataModel>> getShopsRepository() {
    return webServices.getShopsWebServices();
  }

  Future<List<ProductDataModel>> getProductsByShopIdRepository(String id) {
    return webServices.getProductsByShopIdWebServices(id);
  }

  Future<List<CategoryDataModel>> getCategoriesRepository() {
    return webServices.getCategoriesWebServices();
  }
}
