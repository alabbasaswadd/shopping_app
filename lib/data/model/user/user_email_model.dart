import 'package:json_annotation/json_annotation.dart';
part 'user_email_model.g.dart';

@JsonSerializable()
class UserEmailModel {
  final String? userName;
  final String? password;
  final String? shopId;
  final String? customerId;
  UserEmailModel({this.userName, this.password, this.customerId, this.shopId});

  factory UserEmailModel.fromJson(Map<String, dynamic> json) =>
      _$UserEmailModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserEmailModelToJson(this);
}
