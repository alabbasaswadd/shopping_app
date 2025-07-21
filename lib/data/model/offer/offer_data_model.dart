import 'package:json_annotation/json_annotation.dart';
import 'package:shopping_app/data/model/products/product_data_model.dart';
import 'package:shopping_app/data/model/shop/shop_data_model.dart';
part 'offer_data_model.g.dart';

@JsonSerializable(explicitToJson: true)
class OfferDataModel {
  final String? shopId;
  final String? productId;
  final String? imageUrl;
  final String? name;
  final String? description;
  final int? discountPercentage;
  final num? newPrice;
  final DateTime? startDate;
  final DateTime? endDate;
  final ShopDataModel? shop;
  final ProductDataModel? product;

  OfferDataModel({
    this.shopId,
    this.productId,
    this.imageUrl,
    this.name,
    this.description,
    this.discountPercentage,
    this.newPrice,
    this.startDate,
    this.endDate,
    this.shop,
    this.product,
  });

  factory OfferDataModel.fromJson(Map<String, dynamic> json) =>
      _$OfferDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$OfferDataModelToJson(this);
}
