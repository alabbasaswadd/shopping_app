import 'package:json_annotation/json_annotation.dart';
import 'package:shopping_app/core/api/errors/error_model.dart';

part 'register_model.g.dart';

@JsonSerializable(explicitToJson: true)
class RegisterResponseModel {
  final bool succeeded;
  final Map<String, dynamic>? data;
  final ErrorModel errors;
  final String? message;

  RegisterResponseModel({
    required this.succeeded,
    this.data,
    required this.errors,
    this.message,
  });

  factory RegisterResponseModel.fromJson(Map<String, dynamic> json) =>
      _$RegisterResponseModelFromJson(json);
  Map<String, dynamic> toJson() => _$RegisterResponseModelToJson(this);
}
