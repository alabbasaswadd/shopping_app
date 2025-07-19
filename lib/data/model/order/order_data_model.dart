import 'package:json_annotation/json_annotation.dart';
import 'package:shopping_app/data/model/order/order_items_model.dart';

part 'order_data_model.g.dart';

@JsonSerializable(includeIfNull: false)
class OrderDataModel {
  final String? id;
  final String? customerId;
  final String? shopId;
  final String? orderDate;
  final double? totalAmount;
  final String? orderState;
  final List<OrderItemsModel>? orderItems;

  OrderDataModel({
    this.id,
    this.customerId,
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
