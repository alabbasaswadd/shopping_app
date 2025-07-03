import 'package:json_annotation/json_annotation.dart';
part 'user_address_model.g.dart';

@JsonSerializable()
class UserAddressModel {
  final String? city;
  final String? street;
  final String? floor;
  final String? apartment;
  final bool? defaultAddress;

  UserAddressModel({
    required this.city,
    required this.street,
    required this.floor,
    required this.apartment,
    required this.defaultAddress,
  });

  factory UserAddressModel.fromJson(Map<String, dynamic> json) =>
      _$UserAddressModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserAddressModelToJson(this);
}