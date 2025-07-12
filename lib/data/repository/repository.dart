import 'package:dio/dio.dart';
import 'package:shopping_app/data/model/cart/add_to_cart_request.dart';
import 'package:shopping_app/data/model/cart/cart_data_model.dart';
import 'package:shopping_app/data/model/order/order_data_model.dart';
import 'package:shopping_app/data/model/products/product_data_model.dart';
import 'package:shopping_app/data/model/shop/shop_data_model.dart';
import 'package:shopping_app/data/model/user/user_data_model.dart';
import 'package:shopping_app/data/web_services/web_services.dart';

class Repository {
  final WebServices webServices;
  Repository(this.webServices);
  Future<List<ProductDataModel>> getDataRepository() async {
    final products = await webServices.getDataWebServices();
    return products;
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

  Future<Response> getCategoriesRepository() {
    return webServices.getCategoriesWebServices();
  }

  Future<Response> getProductsByCategoryRepository(String categoryId) {
    return webServices.getProductsByCategoryWebServices(categoryId);
  }

  Future<List<CartDataModel>> getCartRepository() {
    return webServices.getCartWebServices();
  }

  Future<Response> addProductToTheCartRepository(AddToCartRequest data) {
    return webServices.addProductToTheCartWebServices(data);
  }

  Future<Response> deleteProductFromCartRepository(String productId) {
    return webServices.deleteProductFromCartWebServices(productId);
  }

  Future<Response> clearCartRepository(String userId) {
    return webServices.clearCartWebServices(userId);
  }

  Future<Response> addOrderRepository(OrderDataModel dataOrder) {
    return webServices.addOrderWebServices(dataOrder);
  }

  Future<Response> getOrdersRepository() {
    return webServices.getOrdersWebServices();
  }

  Future<Response> updateOrderRepository(String orderId) {
    return webServices.updateOrderWebServices(orderId);
  }

  Future<Response> deleteOrderRepository(String orderId) {
    return webServices.deleteOrderWebServices(orderId);
  }
}
