import 'package:json_annotation/json_annotation.dart';
import 'package:shopping_app/data/model/products/product_data_model.dart';

part 'product_response_model.g.dart';

@JsonSerializable()
class ProductResponseModel {
  final bool succeeded;
  final List<ProductDataModel>? data;

  ProductResponseModel({
    required this.succeeded,
    this.data,
  });

  factory ProductResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ProductResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductResponseModelToJson(this);
}
