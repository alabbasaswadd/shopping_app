import 'package:json_annotation/json_annotation.dart';

part 'delivery_email_model.g.dart';

@JsonSerializable()
class DeliveryEmailModel {
  final String? shopId;
  final String? customerId;
  final String? deliveryCompanyId;
  final String? userName;
  final String? password;

  DeliveryEmailModel({
    this.shopId,
    this.customerId,
    this.deliveryCompanyId,
    this.userName,
    this.password,
  });

  factory DeliveryEmailModel.fromJson(Map<String, dynamic> json) =>
      _$DeliveryEmailModelFromJson(json);

  Map<String, dynamic> toJson() => _$DeliveryEmailModelToJson(this);
}
