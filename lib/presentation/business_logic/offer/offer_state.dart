import 'package:shopping_app/data/model/offer/offer_data_model.dart';
import 'package:shopping_app/data/model/offer/offer_response_model.dart';
import 'package:shopping_app/data/model/order/order_data_model.dart';

abstract class OfferState {}

class OfferLoading extends OfferState {}

class OfferEmpty extends OfferState {}

class OfferLoaded extends OfferState {
  final OfferResponseModel offers;
  OfferLoaded(this.offers);
}

class OfferError extends OfferState {
  final String message;
  OfferError(this.message);
}
