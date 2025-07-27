import 'package:json_annotation/json_annotation.dart';

part 'category_data_model.g.dart';

@JsonSerializable()
class CategoryDataModel {
  final String? id;
  final String? name;
  final String? image;
  CategoryDataModel({
    this.id,
    this.name,
    this.image,
  });

  factory CategoryDataModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryDataModelFromJson(json);
  Map<String, dynamic> toJson() => _$CategoryDataModelToJson(this);
}
