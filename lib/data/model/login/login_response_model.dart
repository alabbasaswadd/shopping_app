import 'package:json_annotation/json_annotation.dart';
import 'package:shopping_app/core/api/errors/error_model.dart';
import 'package:shopping_app/data/model/login/login_data_model.dart';

part 'login_response_model.g.dart';

@JsonSerializable()
class LoginResponseModel {
  final bool? succeeded;
  final LoginDataModel? data;
  final ErrorModel? errors;
  LoginResponseModel({
    this.succeeded,
    this.data,
    this.errors,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseModelFromJson(json);
  Map<String, dynamic> toJson() => _$LoginResponseModelToJson(this);
}
