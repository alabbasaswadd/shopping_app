import 'package:bloc/bloc.dart';
import 'package:get/get.dart';
import 'package:shopping_app/core/constants/functions.dart';
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
    print(response);
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
      print(e);
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
        final shopsJsonList = response.data['data'] as List;
        final shops =
            shopsJsonList.map((json) => ShopDataModel.fromJson(json)).toList();

        // افترض أن getProductsRepository تُرجع Future<List<ProductModel>>
        final products = await repository.getProductsRepository(shopId: id);

        emit(ShopProductsLoaded(products, shops));
      } else {
        emit(ShopProductsError("لا يوجد منتجات في هذا المتجر"));
      }
    } catch (e) {
      print("❌ Error: $e");
      emit(ShopProductsError(
          "حدث خطأ أثناء جلب المنتجات المتاحة: ${e.toString()}"));
    }
  }
}
