import 'package:json_annotation/json_annotation.dart';
import 'package:shopping_app/core/api/errors/error_model.dart';
import 'package:shopping_app/data/model/category/category_data_model.dart';
part 'category_response_model.g.dart';
@JsonSerializable()
class CategoryResponseModel {
  final bool succeeded;
  final List<CategoryDataModel>? data;
  final ErrorModel? errors;
  CategoryResponseModel({required this.succeeded, this.data, this.errors});
  factory CategoryResponseModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryResponseModelFromJson(json);
  Map<String, dynamic> toJson() => _$CategoryResponseModelToJson(this);
}
