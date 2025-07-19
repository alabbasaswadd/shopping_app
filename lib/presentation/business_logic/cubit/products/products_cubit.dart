import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shopping_app/data/model/cart/add_to_cart_request.dart';
import 'package:shopping_app/data/model/products/product_data_model.dart';
import 'package:shopping_app/data/repository/repository.dart';
import 'package:shopping_app/data/web_services/web_services.dart';
part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  final Repository repository = Repository(WebServices());

  ProductsCubit() : super(ProductsLoading());

  void getProducts(
      {String? shopId,
      String? category,
      double? minPrice,
      double? maxPrice}) async {
    emit(ProductsLoading());

    final response = await repository.getProductsRepository();
    if (response.statusCode == 200 &&
        response.data != null &&
        response.data['succeeded'] == true) {
      final productsJson = response.data['data'];

      if (productsJson is List) {
        final products = productsJson
            .map((e) => ProductDataModel.fromJson(e as Map<String, dynamic>))
            .toList();

        emit(ProductsLoaded(products));
      } else {
        emit(ProductsError("البيانات غير متوقعة"));
      }
    } else {
      emit(ProductsError("لا يوجد منتجات"));
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
        emit(ProductsLoaded(products));

        print("-------------------------- ");
      } else {
        print(response);
        print("❌ خطأ أثناء الإضافة إلى السلة: ++++++");
        final dataProducts = await repository.getProductsRepository();
        final products = dataProducts.data['data'];
        emit(ProductsFeildAdd("فشل في إضافة المنتج إلى السلة."));
        emit(ProductsLoaded(products));
      }
      print(response.statusCode);
      print(response.statusMessage);
    } catch (e, stackTrace) {
      print(stackTrace);
      emit(ProductsFeildAdd("حدث خطأ غير متوقع أثناء الإضافة."));
    }
  }
}
