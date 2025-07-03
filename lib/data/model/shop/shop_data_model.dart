import 'package:json_annotation/json_annotation.dart';

part 'shop_data_model.g.dart';

@JsonSerializable()
class ShopDataModel {
  final String? id;
  final String? firstName;
  final String? lastName;
  final String? phone;
  final String? addressId;
  final String? email;
  final dynamic address; // لو لاحقاً تحب تفصلها في موديل AddressModel

  ShopDataModel({
    this.id,
    this.firstName,
    this.lastName,
    this.phone,
    this.addressId,
    this.email,
    this.address,
  });

  factory ShopDataModel.fromJson(Map<String, dynamic> json) =>
      _$ShopDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$ShopDataModelToJson(this);
}
