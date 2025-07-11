import 'package:bloc/bloc.dart';
import 'package:shopping_app/data/model/category/category_data_model.dart';
import 'package:shopping_app/data/model/products/product_data_model.dart';
import 'package:shopping_app/data/repository/repository.dart';
import 'package:shopping_app/data/web_services/web_services.dart';
import 'package:shopping_app/presentation/business_logic/cubit/category/category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  Repository repository = Repository(WebServices());
  CategoryCubit() : super(CategoryInitial());
  void getCategories() async {
    try {
      emit(CategoryLoading());
      final response = await repository.getCategoriesRepository();
      print(response.statusCode);
      print(response.statusMessage);
      print(response.data);
      if (response.statusCode == 200 &&
          response.data != null &&
          response.data['succeeded'] == true) {
        final List<CategoryDataModel> categories =
            (response.data['data'] as List)
                .map((e) => CategoryDataModel.fromJson(e))
                .toList();
        emit(CategoryLoaded(categories));
      } else {
        emit(CategoryError("لا يوجد "));
      }
    } catch (e) {
      emit(CategoryError("error $e"));
    }
  }

  void getProductsByCategory(String categoryName) async {
    try {
      emit(ProductsLoading());

      final response =
          await repository.getProductsByCategoryRepository(categoryName);
      print(response.statusCode);
      print(response.statusMessage);
      print(response.data);
      if (response.statusCode == 200 &&
          response.data != null &&
          response.data['succeeded'] == true) {
        final List<dynamic> rawProducts = response.data['data'];
        final List<ProductDataModel> products =
            rawProducts.map((item) => ProductDataModel.fromJson(item)).toList();

        emit(ProductsSuccess(products));
      } else {
        print(response.data);
        emit(ProductsError("المنتجات فارغة أو حصل خطأ"));
      }
    } catch (e) {
      emit(ProductsError("حدث خطأ: $e"));
    }
  }
}
