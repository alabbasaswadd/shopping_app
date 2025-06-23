import 'package:get/get.dart' hide Response;
import 'package:dio/dio.dart';
import 'package:shopping_app/data/model/products_model.dart';
import 'package:shopping_app/data/model/user_model.dart';
import 'package:shopping_app/data/web_services/web_services.dart';

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

  Future<UserModel> getUserRepository(String userId) {
    return webServices.getUserWebServices(userId);
  }

  Future<void> updateUserRepository(String userId, UserModel user) {
    return webServices.updateUserWebServices(userId, user);
  }

  Future<void> deleteUserRepository(String userId) {
    return webServices.deleteUserWebServices(userId);
  }
}
