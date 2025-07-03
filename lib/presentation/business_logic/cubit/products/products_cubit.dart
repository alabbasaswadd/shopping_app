import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shopping_app/data/model/products/product_data_model.dart';
import 'package:shopping_app/data/repository/products_repository.dart';
import 'package:shopping_app/data/web_services/web_services.dart';
part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  Repository productsRepository = Repository(WebServices());
  List<ProductDataModel> products = [];
  ProductsCubit() : super(ProductsLoading());

  void getData() {
    emit(ProductsLoading());
    productsRepository.getData().then((products) {
      this.products = products;

      emit(ProductsSuccess(products));
    }).catchError((error) {
      emit(ProductsError(error.toString()));
    });
  }
}
