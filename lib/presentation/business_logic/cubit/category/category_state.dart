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

abstract class CategoryState {}

class CategoryInitial extends CategoryState {}

class CategoryLoading extends CategoryState {}

class CategoryLoaded extends CategoryState {
  final List<CategoryDataModel> Categories;

  CategoryLoaded(this.Categories);
}

class CategoryError extends CategoryState {
  final String error;

  CategoryError(this.error);
}
