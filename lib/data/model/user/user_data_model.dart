import 'package:json_annotation/json_annotation.dart';
import 'package:shopping_app/data/model/user/user_address_model.dart';
import 'package:shopping_app/data/model/user/user_email_model.dart';

part 'user_data_model.g.dart';

@JsonSerializable()
class UserDataModel {
  final String? id;
  final String? firstName;
  final String? lastName;
  final String? shoppingCartId;
  final String? dateOfBirth;
  final String? emailId;
  final String? phone;
  final String? addressId;
  final UserEmailModel? email;
  final UserAddressModel? address;

  UserDataModel({
    this.id,
    this.firstName,
    this.lastName,
    this.shoppingCartId,
    this.dateOfBirth,
    this.emailId,
    this.phone,
    this.addressId,
    this.email,
    this.address,
  });

  factory UserDataModel.fromJson(Map<String, dynamic> json) =>
      _$UserDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserDataModelToJson(this);
}
