import 'package:json_annotation/json_annotation.dart';
import 'package:shopping_app/core/constants/const.dart';
import 'package:shopping_app/data/model/order/order_items_model.dart';
import 'package:shopping_app/data/model/shop/shop_data_model.dart';

part 'order_data_model.g.dart';

@JsonSerializable(includeIfNull: false)
class OrderDataModel {
  final String? id;
  final String? customerId;
  final String? deliveryCompanyId;
  final String? noteDelivery;
  final ShopDataModel? shop;
  final String? shopId;
  final String? orderDate;
  final double? totalAmount;
  final List<OrderItemsModel>? orderItems;

  @JsonKey(fromJson: _orderStateEnumFromJson, toJson: _orderStateEnumToJson)
  final OrderStateEnum? orderState;

  OrderDataModel({
    this.id,
    this.customerId,
    this.deliveryCompanyId,
    this.noteDelivery,
    this.shop,
    this.shopId,
    this.orderDate,
    this.totalAmount,
    this.orderState,
    this.orderItems,
  });

  factory OrderDataModel.fromJson(Map<String, dynamic> json) =>
      _$OrderDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderDataModelToJson(this);
}

// دوال تحويل enum ⇄ int
OrderStateEnum? _orderStateEnumFromJson(dynamic value) {
  if (value is int && value >= 0 && value < OrderStateEnum.values.length) {
    return OrderStateEnum.values[value];
  }
  return null; // أو throw إذا أردت رفع خطأ
}

int? _orderStateEnumToJson(OrderStateEnum? state) {
  return state?.index;
}
