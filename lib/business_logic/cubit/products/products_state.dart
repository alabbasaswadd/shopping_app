part of 'products_cubit.dart';

@immutable
sealed class ProductsState {}

final class ProductsInitial extends ProductsState {}

class ProductsSuccess extends ProductsState {
  final List<ProductsModel> products;
  ProductsSuccess(this.products);
}

class ProductsError extends ProductsState {
  // ignore: prefer_typing_uninitialized_variables
  final error;
  ProductsError(this.error);
}

class ProductsLoading extends ProductsState {}
