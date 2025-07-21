import 'package:bloc/bloc.dart';
import 'package:shopping_app/data/repository/repository.dart';
import 'package:shopping_app/data/web_services/web_services.dart';
import 'package:shopping_app/presentation/business_logic/offer/offer_state.dart';

class OfferCubit extends Cubit<OfferState> {
  OfferCubit() : super(OfferLoading());
  Repository repository = Repository(WebServices());
  Future<void> getOffers() async {
    try {
      emit(OfferLoading());
      final offers = await repository.getOffersRepository();
      if (offers != null) {
        emit(OfferLoaded(offers));
      } else {
        emit(OfferEmpty());
      }
    } catch (e) {
      emit(OfferError("Error"));
    }
  }
}
