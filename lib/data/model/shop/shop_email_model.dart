import 'package:json_annotation/json_annotation.dart';

part 'shop_email_model.g.dart';

@JsonSerializable()
class ShopEmailModel {
  final String? shopId;
  final String? customerId;
  final String? deliveryCompanyId;
  final String? userName;
  final String? password;

  ShopEmailModel({
    this.shopId,
    this.customerId,
    this.deliveryCompanyId,
    this.userName,
    this.password,
  });

  factory ShopEmailModel.fromJson(Map<String, dynamic> json) =>
      _$ShopEmailModelFromJson(json);

  Map<String, dynamic> toJson() => _$ShopEmailModelToJson(this);
}
