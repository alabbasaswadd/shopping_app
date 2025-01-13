import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shopping_app/data/model/products_model.dart';
import 'package:shopping_app/data/repository/products_repository.dart';

part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  ProductsRepository productsRepository;
  List<ProductsModel> products = [];
  ProductsCubit(this.productsRepository) : super(ProductsInitial());

  void getData() {
    emit(ProductsLoading()); // حالة تحميل
    productsRepository.getData().then((products) {
      this.products = products; // حفظ البيانات
      emit(ProductsSuccess(products)); // تحديث الحالة عند نجاح الجلب
    }).catchError((error) {
      emit(ProductsError(error.toString())); // تحديث الحالة عند وجود خطأ
    });
  }

  List<ProductsModel> listOfSearch = [];
}
