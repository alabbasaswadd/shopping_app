import 'package:json_annotation/json_annotation.dart';

part 'delivery_data_model.g.dart';

@JsonSerializable()
class DeliveryDataModel {
  final String? id;
  final String? name;
  final String? contactPerson;
  final String? phoneNumber;
  final String? email;
  final String? website;
  final String? address;
  final String? coverageAreas;
  final String? logo;
  final double? basePrice;
  final double? pricePerKm;
  final bool? isActive;
  final String? logoUrl;
  final List<dynamic>? deliveries;
  final List<dynamic>? deliveryCompanyCoverageAreas;

  DeliveryDataModel({
    this.id,
    this.name,
    this.contactPerson,
    this.phoneNumber,
    this.email,
    this.logo,
    this.website,
    this.address,
    this.coverageAreas,
    this.basePrice,
    this.pricePerKm,
    this.isActive,
    this.logoUrl,
    this.deliveries = const [],
    this.deliveryCompanyCoverageAreas = const [],
  });

  factory DeliveryDataModel.fromJson(Map<String, dynamic> json) =>
      _$DeliveryDataModelFromJson(json);
  Map<String, dynamic> toJson() => _$DeliveryDataModelToJson(this);
}
