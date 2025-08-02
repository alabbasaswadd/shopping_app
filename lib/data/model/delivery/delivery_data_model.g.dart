// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delivery_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeliveryDataModel _$DeliveryDataModelFromJson(Map<String, dynamic> json) =>
    DeliveryDataModel(
      id: json['id'] as String?,
      name: json['name'] as String?,
      contactPerson: json['contactPerson'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      email: json['email'] == null
          ? null
          : DeliveryEmailModel.fromJson(json['email'] as Map<String, dynamic>),
      logo: json['logo'] as String?,
      website: json['website'] as String?,
      address: json['address'] as String?,
      coverageAreas: json['coverageAreas'] as String?,
      basePrice: (json['basePrice'] as num?)?.toDouble(),
      pricePerKm: (json['pricePerKm'] as num?)?.toDouble(),
      isActive: json['isActive'] as bool?,
      logoUrl: json['logoUrl'] as String?,
      deliveries: json['deliveries'] as List<dynamic>? ?? const [],
      deliveryCompanyCoverageAreas:
          json['deliveryCompanyCoverageAreas'] as List<dynamic>? ?? const [],
    );

Map<String, dynamic> _$DeliveryDataModelToJson(DeliveryDataModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'contactPerson': instance.contactPerson,
      'phoneNumber': instance.phoneNumber,
      'email': instance.email,
      'website': instance.website,
      'address': instance.address,
      'coverageAreas': instance.coverageAreas,
      'logo': instance.logo,
      'basePrice': instance.basePrice,
      'pricePerKm': instance.pricePerKm,
      'isActive': instance.isActive,
      'logoUrl': instance.logoUrl,
      'deliveries': instance.deliveries,
      'deliveryCompanyCoverageAreas': instance.deliveryCompanyCoverageAreas,
    };
