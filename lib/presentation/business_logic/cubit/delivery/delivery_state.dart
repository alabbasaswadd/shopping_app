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

import 'package:shopping_app/data/model/delivery/delivery_data_model.dart';
import 'package:shopping_app/data/model/shop/shop_data_model.dart';

abstract class DeliveryState {}

class DeliveryLoading extends DeliveryState {}
class DeliveryEmpty extends DeliveryState {}

class DeliveryLoaded extends DeliveryState {
  final List<DeliveryDataModel> deliveryCompanies;
  DeliveryLoaded(this.deliveryCompanies);
}

class DeliveryError extends DeliveryState {
  final String error;
  DeliveryError(this.error);
}
