import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  final String firstName;
  final String lastName;
  final String birthDate;
  final int gender;
  final String email;
  final String phone;
  final String password;
  final AddressModel address;

  UserModel({
    required this.firstName,
    required this.lastName,
    required this.birthDate,
    required this.gender,
    required this.email,
    required this.phone,
    required this.password,
    required this.address,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}

@JsonSerializable()
class AddressModel {
  final String city;
  final String street;
  final String floor;
  final String apartment;
  final bool defaultAddress;

  AddressModel({
    required this.city,
    required this.street,
    required this.floor,
    required this.apartment,
    required this.defaultAddress,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) =>
      _$AddressModelFromJson(json);
  Map<String, dynamic> toJson() => _$AddressModelToJson(this);
}
