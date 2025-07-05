import 'package:json_annotation/json_annotation.dart';

part 'shopping_cart_items_model.g.dart';

@JsonSerializable()
class ShoppingCartItemsModel {
  final String? id;
  final String? shoppingCartId;
  final String? productId;
  final String? productName;
  final String? productImage;
  final int? productPrice;
  final String? shopId;
  int? quantity;

  ShoppingCartItemsModel({
    this.id,
    this.shoppingCartId,
    this.productId,
    this.productName,
    this.productImage,
    this.productPrice,
    this.shopId,
    this.quantity,
  });

  factory ShoppingCartItemsModel.fromJson(Map<String, dynamic> json) =>
      _$ShoppingCartItemsModelFromJson(json);

  Map<String, dynamic> toJson() => _$ShoppingCartItemsModelToJson(this);
}
