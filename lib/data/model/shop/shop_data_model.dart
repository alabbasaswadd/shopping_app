import 'package:json_annotation/json_annotation.dart';
import 'package:shopping_app/core/constants/const.dart';
import 'package:shopping_app/data/model/shop/shop_email_model.dart';

part 'shop_data_model.g.dart';

@JsonSerializable()
class ShopDataModel {
  final String? id;
  final String? firstName;
  final String? lastName;
  final String? phone;
  final String? addressId;
  final ShopEmailModel? email;
  final String? imageUrl;

  @JsonKey(fromJson: _shopStateEnumFromJson, toJson: _shopStateEnumToJson)
  final ShopStateEnum? shopState;

  final dynamic address;

  ShopDataModel({
    this.id,
    this.firstName,
    this.lastName,
    this.phone,
    this.addressId,
    this.email,
    this.imageUrl,
    this.shopState,
    this.address,
  });

  factory ShopDataModel.fromJson(Map<String, dynamic> json) =>
      _$ShopDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$ShopDataModelToJson(this);

  static ShopStateEnum? _shopStateEnumFromJson(dynamic value) {
    if (value is int && value >= 0 && value < ShopStateEnum.values.length) {
      return ShopStateEnum.values[value];
    }
    return null;
  }

  static int? _shopStateEnumToJson(ShopStateEnum? state) {
    return state?.index;
  }
}
