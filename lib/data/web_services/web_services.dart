import 'package:dio/dio.dart';
import 'package:shopping_app/core/constants/functions.dart';
import 'package:shopping_app/core/constants/route.dart';
import 'package:shopping_app/data/model/cart/add_to_cart_request.dart';
import 'package:shopping_app/data/model/cart/cart_data_model.dart';
import 'package:shopping_app/data/model/order/order_data_model.dart';
import 'package:shopping_app/data/model/order/order_request_data_model.dart';
import 'package:shopping_app/data/model/user/user_data_model.dart';

class WebServices {
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      validateStatus: (status) {
        return status != null && status < 500;
      },
    ),
  );
  Future<Response> getProductsWebServices({
    String? shopId,
    String? category,
    double? minPrice,
    double? maxPrice,
  }) async {
    final token = await UserPreferencesService.getToken();

    return await dio.get(
      "$baseUrl$getAllProducts",
      options: Options(headers: {
        "Authorization": "Bearer $token",
      }),
      queryParameters: {
        if (shopId != null) "shopId": shopId,
        if (category != null) "category": category,
        if (minPrice != null) "minPrice": minPrice,
        if (maxPrice != null) "maxPrice": maxPrice,
      },
    );
  }

  Future<Response> signUpWebService(Map<String, dynamic> data) async {
    final response = await dio.post(
      "$baseUrl$signUp",
      data: data,
    );
    return response;
  }

  Future<Response> loginWebServices(String email, String password) async {
    final response = await dio.post(
      "$baseUrl$login",
      data: {
        'email': email,
        'password': password,
      },
    );
    return response;
  }

  Future<Response> getUserWebServices(String userId) async {
    final token = await UserPreferencesService.getToken();
    final response = await dio.get(
      '$baseUrl${getUserRoute(userId)}',
      options: Options(headers: {"Authorization": "Bearer $token"}),
    );
    return response;
  }

  Future<Response> updateUserWebServices(
      String userId, UserDataModel user) async {
    final token = await UserPreferencesService.getToken();
    var response = await dio.put(
      '$baseUrl${updateUserRoute(userId)}',
      data: user.toJson(),
      options: Options(headers: {"Authorization": "Bearer $token"}),
    );
    return response;
  }

  Future<Response> deleteUserWebServices(String userId) async {
    final token = await UserPreferencesService.getToken();

    final response = await dio.delete(
      '$baseUrl${deleteUserRoute(userId)}',
      options: Options(headers: {"Authorization": "Bearer $token"}),
    );
    return response;
  }

  Future<Response> getShopsWebServices() async {
    final token = await UserPreferencesService.getToken();

    final response = await dio.get(
      '$baseUrl$getShops',
      options: Options(headers: {"Authorization": "Bearer $token"}),
    );

    return response;
  }

  Future<Response> getShopByIdWebServices(String id) async {
    final token = await UserPreferencesService.getToken();

    final response = await dio.get(
      '$baseUrl${getShopById(id)}',
      options: Options(headers: {"Authorization": "Bearer $token"}),
    );

    return response;
  }

  Future<Response> getProductsByShopIdWebServices(String id) async {
    final token = await UserPreferencesService.getToken();

    final response = await dio.get(
      '$baseUrl$getAllProducts',
      queryParameters: {"shopId": id},
      options: Options(headers: {"Authorization": "Bearer $token"}),
    );

    return response;
  }

  Future<Response> getCategoriesWebServices() async {
    final token = await UserPreferencesService.getToken();
    final response = await dio.get('$baseUrl$getCategoyries',
        options: Options(headers: {"Authorization": "Bearer $token"}));
    return response;
  }

  Future<Response> getProductsByCategoryWebServices(String categoryName) async {
    final token = await UserPreferencesService.getToken();
    final response = await dio.get('$baseUrl$proca',
        options: Options(headers: {"Authorization": "Bearer $token"}),
        queryParameters: {"category": categoryName});
    return response;
  }

  Future<List<CartDataModel>> getCartWebServices() async {
    final token = await UserPreferencesService.getToken();
    final shoppingCartId = UserSession.shoppingCartId;

    final response = await dio.get(
      '$baseUrl$getCart',
      options: Options(headers: {"Authorization": "Bearer $token"}),
      queryParameters: {"id": shoppingCartId},
    );

    final data = response.data['data'];
    if (data is List) {
      return data.map((e) => CartDataModel.fromJson(e)).toList();
    } else {
      return [];
    }
  }

  Future<Response> addProductToTheCartWebServices(AddToCartRequest data) async {
    final token = await UserPreferencesService.getToken();

    final response = await dio.post(
      '$baseUrl$addProductToTheCart',
      options: Options(headers: {"Authorization": "Bearer $token"}),
      data: data.toJson(),
    );
    return response;
  }

  Future<Response> deleteProductFromCartWebServices(String productId) async {
    final token = await UserPreferencesService.getToken();
    final response = await dio.delete(
      '$baseUrl${deleteProductFromCart(productId)}',
      options: Options(headers: {"Authorization": "Bearer $token"}),
    );
    return response;
  }

  Future<Response> clearCartWebServices(String userId) async {
    final token = await UserPreferencesService.getToken();
    final response = await dio.delete(
      '$baseUrl${clearCart(userId)}',
      options: Options(headers: {"Authorization": "Bearer $token"}),
    );
    return response;
  }

  Future<Response> addOrderWebServices(OrderRequestDataModel dataOrder) async {
    final token = await UserPreferencesService.getToken();
    final response = await dio.post(
      data: dataOrder.toJson(),
      '$baseUrl$addOrder',
      options: Options(headers: {"Authorization": "Bearer $token"}),
    );
    return response;
  }

  Future<Response> getOrdersWebServices() async {
    final token = await UserPreferencesService.getToken();
    final customerId = UserSession.id ?? '';
    final response = await dio.get(
      '$baseUrl${getOrders(customerId)}',
      options: Options(headers: {"Authorization": "Bearer $token"}),
    );
    return response;
  }

  Future<Response> getOrderByIdWebServices(String orderId) async {
    final token = await UserPreferencesService.getToken();
    final response = await dio.get(
      '$baseUrl${getOrderById(orderId)}',
      options: Options(headers: {"Authorization": "Bearer $token"}),
    );
    return response;
  }

  Future<Response> getOffersWebServices() async {
    final token = await UserPreferencesService.getToken();
    final response = await dio.get(
      '$baseUrl$offer',
      options: Options(headers: {"Authorization": "Bearer $token"}),
    );
    return response;
  }

  Future<Response> updateOrderWebServices(
      String orderId, OrderDataModel data) async {
    final token = await UserPreferencesService.getToken();
    final response = await dio.put(
      '$baseUrl${updateOrder(orderId)}',
      data: data.toJson(),
      options: Options(headers: {"Authorization": "Bearer $token"}),
    );
    return response;
  }

  Future<Response> deleteOrderWebServices(String orderId) async {
    final token = await UserPreferencesService.getToken();
    final response = await dio.delete(
      '$baseUrl${deleteOrder(orderId)}',
      options: Options(headers: {"Authorization": "Bearer $token"}),
    );
    return response;
  }

  Future<Response> getDeliveryCompaniesWebServices() async {
    final token = await UserPreferencesService.getToken();
    final response = await dio.get(
      '$baseUrl$getDeliveryCompanies',
      options: Options(headers: {"Authorization": "Bearer $token"}),
    );
    return response;
  }
}
