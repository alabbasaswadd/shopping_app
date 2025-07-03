import 'package:json_annotation/json_annotation.dart';
import 'package:shopping_app/core/api/errors/error_model.dart';
import 'package:shopping_app/data/model/order/order_data_model.dart';


part 'order_response_model.g.dart';

@JsonSerializable()
class OrderResponseModel {
  final bool succeeded;
  final List<OrderDataModel>? data;
  final ErrorModel? errors;

  OrderResponseModel({
    required this.succeeded,
     this.data,
     this.errors,
  });

  factory OrderResponseModel.fromJson(Map<String, dynamic> json) =>
      _$OrderResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderResponseModelToJson(this);
}
