import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/data/model/products_model.dart';
import 'package:shopping_app/presentation/widget/products/appbar/custom_title_appbar_products.dart';
part 'searching_state.dart';

class SearchingCubit extends Cubit<SearchingState> {
  SearchingCubit() : super(SearchingInitial());
  List<ProductsModel> productsSearch = CustomTitleAppbarProducts.productsSearch;
  void isSearching(TextEditingController controller, List<ProductsModel> all) {
    if (controller.text.isEmpty) {
      List<ProductsModel> produts = CustomTitleAppbarProducts.productsSearch;
      emit(NotSearching(produts));
    } else {
      List<ProductsModel> productsSearching =
          CustomTitleAppbarProducts.productsSearch;
      emit(IsSearching(productsSearching));
    }
  }
}
