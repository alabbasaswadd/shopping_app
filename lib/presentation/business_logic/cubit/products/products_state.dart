part of 'products_cubit.dart';

@immutable
sealed class ProductsState {}

class ProductsLoading extends ProductsState {}

class ProductsAdded extends ProductsState {}

class ProductsFeildAdd extends ProductsState {
  final String error;
  ProductsFeildAdd(this.error);
}

class ProductsLoaded extends ProductsState {
  final List<ProductDataModel> products;
  ProductsLoaded(this.products);
}

class ProductsError extends ProductsState {
  final String error;
  ProductsError(this.error);
}
