import 'package:dio/dio.dart';
import 'package:shopping_app/data/model/cart/add_to_cart_request.dart';
import 'package:shopping_app/data/model/cart/cart_data_model.dart';
import 'package:shopping_app/data/model/offer/offer_response_model.dart';
import 'package:shopping_app/data/model/order/order_data_model.dart';
import 'package:shopping_app/data/model/user/user_data_model.dart';
import 'package:shopping_app/data/web_services/web_services.dart';

class Repository {
  final WebServices webServices;
  Repository(this.webServices);

  Future getProductsRepository({
    String? shopId,
    String? category,
    double? minPrice,
    double? maxPrice,
  }) async {
    return await webServices.getProductsWebServices(
      shopId: shopId,
      category: category,
      minPrice: minPrice,
      maxPrice: maxPrice,
    );
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

  Future<Response> loginRepository(String email, String password) async {
    final response = await webServices.loginWebServices(email, password);
    return response;
  }

  Future<Response> getUserDataRepository(String userId) async {
    final response = await webServices.getUserWebServices(userId);
    return response;
  }

  Future<Response> getUserRepository(String userId) {
    return webServices.getUserWebServices(userId);
  }

  Future<Response> updateUserRepository(String userId, UserDataModel user) {
    return webServices.updateUserWebServices(userId, user);
  }

  Future<Response> deleteUserRepository(String userId) {
    return webServices.deleteUserWebServices(userId);
  }

  Future<Response> getShopsRepository() {
    return webServices.getShopsWebServices();
  }

  Future<Response> getShopsByIdRepository(String id) {
    return webServices.getShopByIdWebServices(id);
  }

  Future<Response> getProductsByShopIdRepository(String id) {
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

  Future<Response> getOrderByIdRepository(String orderId) {
    return webServices.getOrderByIdWebServices(orderId);
  }

  Future<OfferResponseModel?> getOffersRepository() async {
    final response = await webServices.getOffersWebServices();

    if (response.statusCode == 200 &&
        response.data != null &&
        response.data['succeeded'] == true) {
      return OfferResponseModel.fromJson(response.data);
    }

    // في حال الفشل، نرجع null
    return null;
  }

  Future<Response> updateOrderRepository(String orderId, OrderDataModel data) {
    return webServices.updateOrderWebServices(orderId, data);
  }

  Future<Response> deleteOrderRepository(String orderId) {
    return webServices.deleteOrderWebServices(orderId);
  }

  Future<Response> getDeliveryCompaniesRepository() {
    return webServices.getDeliveryCompaniesWebServices();
  }
}
