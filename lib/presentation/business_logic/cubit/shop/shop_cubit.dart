import 'package:bloc/bloc.dart';
import 'package:shopping_app/data/model/products/product_data_model.dart';
import 'package:shopping_app/data/model/shop/shop_data_model.dart';
import 'package:shopping_app/data/repository/repository.dart';
import 'package:shopping_app/data/web_services/web_services.dart';
import 'package:shopping_app/presentation/business_logic/cubit/shop/shop_state.dart';

class ShopCubit extends Cubit<ShopState> {
  Repository repository = Repository(WebServices());
  ShopCubit() : super(ShopInitial());
  void getShops() async {
    emit(ShopLoading());
    final response = await repository.getShopsRepository();
    try {
      if (response.statusCode == 200 &&
          response.data != null &&
          response.data['succeeded'] == true) {
        final shopsJsonList = response.data['data'] as List;
        final shops =
            shopsJsonList.map((json) => ShopDataModel.fromJson(json)).toList();
        emit(ShopLoaded(shops));
      } else {
        emit(ShopError("لا يوجد متاجر"));
      }
    } catch (e) {
      emit(ShopError("حدث خطأ أثناء جلب المتاجر المتاحة: ${e.toString()}"));
    }
  }

  void getProductsByShopId(String id) async {
    emit(ShopProductsLoading());

    try {
      final response = await repository.getProductsByShopIdRepository(id);

      if (response.statusCode == 200 &&
          response.data != null &&
          response.data['succeeded'] == true) {
        final productsJsonList = response.data['data'] as List? ?? [];
        final products = productsJsonList
            .map((json) => ProductDataModel.fromJson(json))
            .toList();

        // هنا نجيب المتجر من أول منتج (لأن كل منتج يحتوي shop)
        final shops = productsJsonList
            .map((json) => ShopDataModel.fromJson(json['shop']))
            .toList();

        emit(ShopProductsLoaded(products, shops));
      } else {
        emit(ShopProductsError("لا يوجد منتجات في هذا المتجر"));
      }
    } catch (e) {
      emit(ShopProductsError(
          "حدث خطأ أثناء جلب المنتجات المتاحة: ${e.toString()}"));
    }
  }

  void getShopById(String id) async {
    try {
      final response = await repository.getShopsByIdRepository(id);

      if (response.statusCode == 200 &&
          response.data != null &&
          response.data['succeeded'] == true) {
        final shop = ShopDataModel.fromJson(response.data['data']);
        emit(ShopByIdLoaded(shop));
      } else {
        emit(ShopProductsError("هذا المتجر غير موجود "));
      }
    } catch (e) {
      emit(ShopProductsError("حدث خطأ أثناء جلب المتجر: ${e.toString()}"));
    }
  }
}
