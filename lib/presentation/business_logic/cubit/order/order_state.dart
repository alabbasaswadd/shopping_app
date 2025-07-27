import 'package:shopping_app/data/model/order/order_data_model.dart';

abstract class OrderState {}

class OrderLoading extends OrderState {}

class OrderEmpty extends OrderState {}

class OrderDeleted extends OrderState {}

class OrderUpdated extends OrderState {
  final OrderDataModel orderData;
  OrderUpdated(this.orderData);
}

class OrderAdded extends OrderState {}

class OrderLoaded extends OrderState {
  final List<OrderDataModel> orders;
  OrderLoaded(this.orders);
}

class OrderError extends OrderState {
  final String error;
  OrderError(this.error);
}
