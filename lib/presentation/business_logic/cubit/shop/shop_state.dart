// import 'package:freezed_annotation/freezed_annotation.dart';
// import 'package:shopping_app/data/model/shop_model.dart';

// part 'shop_state.freezed.dart';

// @freezed
// class ShopState with _$ShopState {
//   const factory ShopState.initial({
//     @Default(false) bool loading,
//     @Default([]) List<ShopModel> shops,
//     String? errorMessage,
//   }) = _Initial;
// }

import 'package:shopping_app/data/model/products/product_data_model.dart';
import 'package:shopping_app/data/model/shop/shop_data_model.dart';

abstract class ShopState {}

class ShopInitial extends ShopState {}

class ShopLoading extends ShopState {}

class ShopLoaded extends ShopState {
  final List<ShopDataModel> shops;

  ShopLoaded(this.shops);
}

class ShopError extends ShopState {
  final String error;

  ShopError(this.error);
}

class ProductsLoading extends ShopState {}

class ProductsSuccess extends ShopState {
  final List<ProductDataModel> products;
  final List<ShopDataModel> shops;
  ProductsSuccess(this.products, this.shops);
}

class ProductsError extends ShopState {
  final String error;
  ProductsError(this.error);
}
