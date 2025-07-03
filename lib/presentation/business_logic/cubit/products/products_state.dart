part of 'products_cubit.dart';

@immutable
sealed class ProductsState {}

class ProductsLoading extends ProductsState {}

class ProductsSuccess extends ProductsState {
  final List<ProductDataModel> products;
  ProductsSuccess(this.products);
}

class ProductsError extends ProductsState {
  final String error;
  ProductsError(this.error);
}
