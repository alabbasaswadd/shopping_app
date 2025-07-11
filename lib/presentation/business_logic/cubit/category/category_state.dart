// import 'package:freezed_annotation/freezed_annotation.dart';
// import 'package:Categoryping_app/data/model/category_model.dart';
// part 'category_state.freezed.dart';

// @freezed
// class CategoryState with _$CategoryState {
//   const factory CategoryState.Initial({
//     @Default(false) bool loading,
//     @Default([]) List<CategoryModel> categories,
//     String? errorMessage,
//   }) = _CategoryState;
// }

import 'package:shopping_app/data/model/category/category_data_model.dart';
import 'package:shopping_app/data/model/products/product_data_model.dart';

abstract class CategoryState {}

class CategoryInitial extends CategoryState {}

class CategoryLoading extends CategoryState {}

class CategoryLoaded extends CategoryState {
  final List<CategoryDataModel> categories;

  CategoryLoaded(this.categories);
}

class CategoryError extends CategoryState {
  final String error;

  CategoryError(this.error);
}

class ProductsLoading extends CategoryState {}

class ProductsSuccess extends CategoryState {
  final List<ProductDataModel> products;

  ProductsSuccess(this.products);
}

class ProductsError extends CategoryState {
  final String error;
  ProductsError(this.error);
}
