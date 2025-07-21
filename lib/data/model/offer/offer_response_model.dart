import 'package:json_annotation/json_annotation.dart';
import 'package:shopping_app/data/model/offer/offer_data_model.dart';

part 'offer_response_model.g.dart';

@JsonSerializable(explicitToJson: true)
class OfferResponseModel {
  final bool succeeded;
  final List<OfferDataModel>? data;
  final Map<String, dynamic>? errors;

  OfferResponseModel({
    required this.succeeded,
    required this.data,
    required this.errors,
  });

  factory OfferResponseModel.fromJson(Map<String, dynamic> json) =>
      _$OfferResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$OfferResponseModelToJson(this);
}
