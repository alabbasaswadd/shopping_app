import 'package:shopping_app/data/model/cart/cart_data_model.dart';

abstract class CartState {}

class CartLoading extends CartState {}

class ProductDeleted extends CartState {}

class CleanCart extends CartState {}
class EmptyCart extends CartState {}

class CartLoaded extends CartState {
  final CartDataModel cart;
  CartLoaded(this.cart);
}

class CartError extends CartState {
  final String error;
  CartError(this.error);
}
