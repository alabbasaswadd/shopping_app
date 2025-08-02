import 'package:json_annotation/json_annotation.dart';

part 'order_request_item_model.g.dart';

@JsonSerializable()
class OrderRequestItemModel {
  final String productId;
  final int quantity;
  final double price;

  OrderRequestItemModel({
    required this.productId,
    required this.quantity,
    required this.price,
  });

  factory OrderRequestItemModel.fromJson(Map<String, dynamic> json) =>
      _$OrderRequestItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderRequestItemModelToJson(this);
}
