import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get/get.dart';
import 'package:shopping_app/data/model/delivery/delivery_data_model.dart';
import 'package:shopping_app/data/repository/repository.dart';
import 'package:shopping_app/data/web_services/web_services.dart';
import 'package:shopping_app/presentation/business_logic/cubit/delivery/delivery_state.dart';

class DeliveryCubit extends Cubit<DeliveryState> {
  DeliveryCubit() : super(DeliveryLoading());
  Repository repository = Repository(WebServices());
  void getDeliveryCompanies() async {
    emit(DeliveryLoading());
    try {
      final response = await repository.getDeliveryCompaniesRepository();
      print(response.statusCode);
      print(response.data);
      if (response.statusCode == 200 &&
          response.data != null &&
          response.data['succeeded'] == true) {
        final deliveryCompanies = (response.data['data'] as List)
            .map((e) => DeliveryDataModel.fromJson(e as Map<String, dynamic>))
            .toList();

        emit(DeliveryLoaded(deliveryCompanies));
      } else {
        emit(DeliveryEmpty());
      }
    } catch (e) {
      emit(DeliveryError("حدث خطأ غير متوقع "));
    }
  }
}
