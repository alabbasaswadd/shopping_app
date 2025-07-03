import 'package:bloc/bloc.dart';
import 'package:shopping_app/data/repository/products_repository.dart';
import 'package:shopping_app/data/web_services/web_services.dart';
import 'package:shopping_app/presentation/business_logic/cubit/category/category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  Repository repository = Repository(WebServices());
  CategoryCubit() : super(CategoryInitial());
  getCategories() async {
    emit(CategoryLoading());
    try {
      final categories = await repository.getCategoriesRepository();
      emit(CategoryLoaded(categories));
    } catch (e) {
      emit(CategoryError("حدث خطأ أثناء جلب الفئات: ${e.toString()}"));
    }
  }
}
