import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/data/model/products/product_data_model.dart';
part 'searching_state.dart';

class SearchingCubit extends Cubit<SearchingState> {
  SearchingCubit() : super(SearchingInitial());

  List<ProductDataModel> allProducts = []; // جميع المنتجات
  List<ProductDataModel> filteredProducts = []; // المنتجات بعد الفلترة
  void setAllProducts(List<ProductDataModel> products) {
    allProducts = products;
  }

  void searchProducts(String query) {
    if (query.isEmpty) {
      emit(NotSearching(allProducts)); // إظهار جميع المنتجات عند مسح البحث
    } else {
      filteredProducts = allProducts
          .where((product) =>
              (product.name ?? "").toLowerCase().contains(query.toLowerCase()))
          .toList();
      emit(IsSearching(filteredProducts)); // تحديث القائمة عند البحث
    }
  }
}
