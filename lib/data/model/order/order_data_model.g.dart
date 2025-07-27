// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderDataModel _$OrderDataModelFromJson(Map<String, dynamic> json) =>
    OrderDataModel(
      id: json['id'] as String?,
      customerId: json['customerId'] as String?,
      deliveryCompanyId: json['deliveryCompanyId'] as String?,
      noteDelivery: json['noteDelivery'] as String?,
      shop: json['shop'] == null
          ? null
          : ShopDataModel.fromJson(json['shop'] as Map<String, dynamic>),
      shopId: json['shopId'] as String?,
      orderDate: json['orderDate'] as String?,
      totalAmount: (json['totalAmount'] as num?)?.toDouble(),
      orderState: _orderStateEnumFromJson(json['orderState']),
      orderItems: (json['orderItems'] as List<dynamic>?)
          ?.map((e) => OrderItemsModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OrderDataModelToJson(OrderDataModel instance) =>
    <String, dynamic>{
      if (instance.id case final value?) 'id': value,
      if (instance.customerId case final value?) 'customerId': value,
      if (instance.deliveryCompanyId case final value?)
        'deliveryCompanyId': value,
      if (instance.noteDelivery case final value?) 'noteDelivery': value,
      if (instance.shop case final value?) 'shop': value,
      if (instance.shopId case final value?) 'shopId': value,
      if (instance.orderDate case final value?) 'orderDate': value,
      if (instance.totalAmount case final value?) 'totalAmount': value,
      if (instance.orderItems case final value?) 'orderItems': value,
      if (_orderStateEnumToJson(instance.orderState) case final value?)
        'orderState': value,
    };
