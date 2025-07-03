import 'package:json_annotation/json_annotation.dart';
import 'package:shopping_app/data/model/cart/shopping_cart_items_model.dart';

part 'cart_data_model.g.dart';

@JsonSerializable()
class CartDataModel {
  final String id;
  final String creationDate;
  final String customerId;
  final List<ShoppingCartItemsModel> shoppingCartItems;

  CartDataModel({
    required this.id,
    required this.creationDate,
    required this.customerId,
    required this.shoppingCartItems,
  });

  factory CartDataModel.fromJson(Map<String, dynamic> json) =>
      _$CartDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$CartDataModelToJson(this);
}
