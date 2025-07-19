import 'package:dio/dio.dart';
import 'package:shopping_app/core/constants/functions.dart';
import 'package:shopping_app/core/constants/route.dart';
import 'package:shopping_app/data/model/cart/add_to_cart_request.dart';
import 'package:shopping_app/data/model/cart/cart_data_model.dart';
import 'package:shopping_app/data/model/order/order_data_model.dart';
import 'package:shopping_app/data/model/products/product_data_model.dart';
import 'package:shopping_app/data/model/products/product_response_model.dart';
import 'package:shopping_app/data/model/shop/shop_data_model.dart';
import 'package:shopping_app/data/model/shop/shop_response_model.dart';
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
  Future<Response> getProductsWebServices(
      {String? shopId,
      String? category,
      double? minPrice,
      double? maxPrice}) async {
    final token = await UserPreferencesService.getToken();
    var response = await dio.get("$baseUrl$getAllProducts",
        options: Options(headers: {
          "Authorization": "Bearer $token",
        }),
        queryParameters: {
          "shopId": shopId,
          "category": category,
          "minPrice": minPrice,
          "maxPrice": maxPrice,
        });
    return response;
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

  Future<UserDataModel> getUserWebServices(String userId) async {
    final response = await dio.get('$baseUrl${getUserRoute(userId)}');
    return UserDataModel.fromJson(response.data['data']);
  }

  Future<void> updateUserWebServices(String userId, UserDataModel user) async {
    await dio.put('$baseUrl${updateUserRoute(userId)}', data: user.toJson());
  }

  Future<void> deleteUserWebServices(String userId) async {
    await dio.delete('$baseUrl${deleteUserRoute(userId)}');
  }

  Future<List<ShopDataModel>> getShopsWebServices() async {
    final token = await UserPreferencesService.getToken();

    final response = await dio.get(
      '$baseUrl$getShops',
      options: Options(headers: {"Authorization": "Bearer $token"}),
    );

    final result = ShopResponseModel.fromJson(response.data);

    return result.data ?? []; // في حال data = null، نرجع قائمة فاضية
  }

  Future<List<ProductDataModel>> getProductsByShopIdWebServices(
      String id) async {
    final token = await UserPreferencesService.getToken();

    final response = await dio.get(
      '$baseUrl$getAllProducts',
      queryParameters: {"shopId": id},
      options: Options(headers: {"Authorization": "Bearer $token"}),
    );
    print('$baseUrl${getProductsByShopId(id)}');
    final result = ProductResponseModel.fromJson(response.data);

    // إذا كانت data = null نرجع قائمة فاضية
    return result.data ?? [];
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

  Future<Response> addOrderWebServices(OrderDataModel dataOrder) async {
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

  Future<Response> updateOrderWebServices(String orderId) async {
    final token = await UserPreferencesService.getToken();
    final response = await dio.put(
      '$baseUrl${updateOrder(orderId)}',
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
}
