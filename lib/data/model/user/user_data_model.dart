import 'package:json_annotation/json_annotation.dart';
import 'package:shopping_app/data/model/user/user_address_model.dart';
import 'package:shopping_app/data/model/user/user_email_model.dart';

part 'user_data_model.g.dart';

@JsonSerializable()
class UserDataModel {
  final String? id;
  final String? firstName;
  final String? lastName;
  final String? birthDate;
  final String? shoppingCartId;
  final int? gender;
  final UserEmailModel? email;
  final String? phone;
  final String? password;
  final UserAddressModel? address;

  UserDataModel({
    this.id,
    this.firstName,
    this.lastName,
    this.birthDate,
    this.shoppingCartId,
    this.gender,
    this.email,
    this.phone,
    this.password,
    this.address,
  });

  factory UserDataModel.fromJson(Map<String, dynamic> json) =>
      _$UserDataModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserDataModelToJson(this);
}
