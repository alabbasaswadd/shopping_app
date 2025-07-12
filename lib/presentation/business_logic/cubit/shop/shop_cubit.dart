import 'package:bloc/bloc.dart';
import 'package:shopping_app/data/repository/repository.dart';
import 'package:shopping_app/data/web_services/web_services.dart';
import 'package:shopping_app/presentation/business_logic/cubit/shop/shop_state.dart';

class ShopCubit extends Cubit<ShopState> {
  Repository repository = Repository(WebServices());
  ShopCubit() : super(ShopInitial());
  void getShops() async {
    emit(ShopLoading());
    try {
      final shops = await repository.getShopsRepository();

      print("✅ عدد المتاجر المحملة: ${shops.length}");
      for (var shop in shops) {
        print("🔸 ${shop.id} ");
      }
      emit(ShopLoaded(shops));
    } catch (e) {
      print("❌ Error: $e");
      emit(ShopError("حدث خطأ أثناء جلب المتاجر المتاحة: ${e.toString()}"));
    }
  }

  void getProductsByShopId(String id) async {
    emit(ProductsLoading());

    try {
      final products = await repository.getProductsByShopIdRepository(id);
      final shops = await repository.getShopsRepository();
      emit(ProductsSuccess(products, shops));
    } catch (e) {
      print("❌ Error: $e");
      emit(
          ProductsError("حدث خطأ أثناء جلب المنتجات المتاحة: ${e.toString()}"));
    }
  }
}
