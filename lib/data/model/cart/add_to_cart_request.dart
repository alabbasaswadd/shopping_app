import 'package:json_annotation/json_annotation.dart';

part 'add_to_cart_request.g.dart';

@JsonSerializable()
class AddToCartRequest {
  final String shoppingCartId;
  final String productId;
  final int quantity;
  final String shopId;

  AddToCartRequest({
    required this.shoppingCartId,
    required this.productId,
    required this.quantity,
    required this.shopId,
  });

  factory AddToCartRequest.fromJson(Map<String, dynamic> json) =>
      _$AddToCartRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AddToCartRequestToJson(this);
}
