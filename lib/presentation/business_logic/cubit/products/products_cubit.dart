import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shopping_app/data/model/cart/add_to_cart_request.dart';
import 'package:shopping_app/data/model/products/product_data_model.dart';
import 'package:shopping_app/data/repository/repository.dart';
import 'package:shopping_app/data/web_services/web_services.dart';

part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  Repository repository = Repository(WebServices());

  ProductsCubit() : super(ProductsLoading());

  void getProducts({
    String? shopId,
    String? category,
    double? minPrice,
    double? maxPrice,
    String? excludeId,
  }) async {
    emit(ProductsLoading());

    try {
      final response = await repository.getProductsRepository(
        shopId: shopId,
        category: category,
        minPrice: minPrice,
        maxPrice: maxPrice,
      );

      if (response.statusCode == 200 &&
          response.data != null &&
          response.data['succeeded'] == true) {
        final productsJson = response.data['data'];

        if (productsJson is List) {
          List<ProductDataModel> products = productsJson
              .map((e) => ProductDataModel.fromJson(e as Map<String, dynamic>))
              .toList();

          if (excludeId != null) {
            products =
                products.where((product) => product.id != excludeId).toList();
          }

          emit(ProductsLoaded(products));
        } else {
          emit(ProductsError("البيانات غير متوقعة"));
        }
      } else {
        emit(ProductsError("فشل تحميل المنتجات"));
      }
    } catch (e) {
      emit(ProductsError("خطأ أثناء الاتصال: $e"));
    }
  }

  void addToCart(AddToCartRequest data) async {
    try {
      final response = await repository.addProductToTheCartRepository(data);
      print(response.data);
      if (response.statusCode == 200 &&
          response.data != null &&
          response.data['succeeded'] == true) {
        final dataProducts = await repository.getProductsRepository();
        final products = dataProducts.data['data'];
        // جلب المنتجات السابقة إن وجدت
        emit(ProductsAdded());
      } else {
        final dataProducts = await repository.getProductsRepository();
        final products = dataProducts.data['data'];
        emit(ProductsFeildAdd("فشل في إضافة المنتج إلى السلة."));
        emit(ProductsLoaded(products));
      }
    } catch (e, stackTrace) {
      print(stackTrace);
      emit(ProductsFeildAdd("حدث خطأ غير متوقع أثناء الإضافة."));
    }
  }
}
