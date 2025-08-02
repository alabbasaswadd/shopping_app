import 'package:json_annotation/json_annotation.dart';
import 'package:shopping_app/data/model/order/order_request_item_model.dart';

part 'order_request_data_model.g.dart';

@JsonSerializable(explicitToJson: true)
class OrderRequestDataModel {
  final String customerId;
  final String shopId;
  final String deliveryCompanyId;
  final String addressId;
  final DateTime orderDate;
  final double totalAmount;
  final String noteDelivery;
  final DateTime shippedDate;
  final int orderState;
  final List<OrderRequestItemModel> orderItems;

  OrderRequestDataModel({
    required this.customerId,
    required this.shopId,
    required this.deliveryCompanyId,
    required this.addressId,
    required this.orderDate,
    required this.totalAmount,
    required this.noteDelivery,
    required this.shippedDate,
    required this.orderState,
    required this.orderItems,
  });

  factory OrderRequestDataModel.fromJson(Map<String, dynamic> json) =>
      _$OrderRequestDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderRequestDataModelToJson(this);
}
