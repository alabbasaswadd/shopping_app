import 'package:json_annotation/json_annotation.dart';
import 'package:shopping_app/data/model/category/category_data_model.dart';

part 'product_data_model.g.dart';

@JsonSerializable()
class ProductDataModel {
  final String? id;
  final String? name;
  final int? price;
  final String? image;
  final String? categoryId;
  final String? currency;
  final String? shopeId;
  final String? description;
  final String? creationDate;
  final String? shope;
  final CategoryDataModel? category;

  ProductDataModel({
    this.id,
    this.name,
    this.price,
    this.image,
    this.categoryId,
    this.currency,
    this.shopeId,
    this.shope,
    this.description,
    this.creationDate,
    this.category,
  });

  factory ProductDataModel.fromJson(Map<String, dynamic> json) =>
      _$ProductDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductDataModelToJson(this);
}
