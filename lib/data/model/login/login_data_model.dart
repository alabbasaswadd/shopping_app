import 'package:json_annotation/json_annotation.dart';

part 'login_data_model.g.dart';

@JsonSerializable()
class LoginDataModel {
  final String? token;
  final String? userName;
  final String? customerId;

  LoginDataModel({
    this.token,
    this.userName,
    this.customerId,
  });

  factory LoginDataModel.fromJson(Map<String, dynamic> json) =>
      _$LoginDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$LoginDataModelToJson(this);
}
