import 'package:json_annotation/json_annotation.dart';
import 'package:shopping_app/data/model/delivery/delivery_data_model.dart';

part 'delivery_response_model.g.dart';

@JsonSerializable()
class DeliveryResponseModel {
  final bool succeeded;
  final List<DeliveryDataModel> data;
  final Map<String, dynamic> errors;

  DeliveryResponseModel({
    required this.succeeded,
    required this.data,
    required this.errors,
  });

  factory DeliveryResponseModel.fromJson(Map<String, dynamic> json) =>
      _$DeliveryResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$DeliveryResponseModelToJson(this);
}
