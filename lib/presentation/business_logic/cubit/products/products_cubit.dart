import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shopping_app/data/model/products_model.dart';
import 'package:shopping_app/data/repository/products_repository.dart';
part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  Repository productsRepository;
  List<ProductsModel> products = [];
  ProductsCubit(this.productsRepository) : super(ProductsLoading());

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
