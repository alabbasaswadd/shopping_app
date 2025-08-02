import 'package:json_annotation/json_annotation.dart';

part 'order_items_model.g.dart';

@JsonSerializable(includeIfNull: false)
class OrderItemsModel {
  final String? id;
  final String? productName;
  final String? orderId;
  final String? productId;
  final int? quantity;
  final double? price;

  OrderItemsModel({
    this.id,
    this.productName,
    this.orderId,
    this.productId,
    this.quantity,
    this.price,
  });

  factory OrderItemsModel.fromJson(Map<String, dynamic> json) =>
      _$OrderItemsModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderItemsModelToJson(this);
}
