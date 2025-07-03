import 'package:json_annotation/json_annotation.dart';
import 'package:shopping_app/core/api/errors/error_model.dart';
import 'package:shopping_app/data/model/cart/cart_data_model.dart';

part 'cart_response_model.g.dart';

@JsonSerializable()
class CartResponseModel {
  final bool succeeded;
  final List<CartDataModel>? data;
  final ErrorModel? errors;

  CartResponseModel({required this.succeeded, this.data, this.errors});

  factory CartResponseModel.fromJson(Map<String, dynamic> json) =>
      _$CartResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$CartResponseModelToJson(this);
}
