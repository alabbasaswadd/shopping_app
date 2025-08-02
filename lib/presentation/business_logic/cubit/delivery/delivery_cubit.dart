import 'package:bloc/bloc.dart';
import 'package:shopping_app/data/model/delivery/delivery_data_model.dart';
import 'package:shopping_app/data/repository/repository.dart';
import 'package:shopping_app/data/web_services/web_services.dart';
import 'package:shopping_app/presentation/business_logic/cubit/delivery/delivery_state.dart';

class DeliveryCubit extends Cubit<DeliveryState> {
  DeliveryCubit() : super(DeliveryLoading());
  Repository repository = Repository(WebServices());
  void getDeliveryCompanies() async {
    try {
      emit(DeliveryLoading());

      final response = await repository.getDeliveryCompaniesRepository();

      if (response.statusCode == 200 &&
          response.data != null &&
          response.data['succeeded'] == true &&
          response.data['data'] != null) {
        final List<dynamic> dataList = response.data['data'];
        final deliveryCompanies = dataList
            .map((e) => DeliveryDataModel.fromJson(e as Map<String, dynamic>))
            .toList();

        if (deliveryCompanies.isNotEmpty) {
          emit(DeliveryLoaded(deliveryCompanies));
        } else {
          emit(DeliveryEmpty()); // ← ستصل هنا إذا كانت القائمة فاضية
        }
      } else {
        emit(DeliveryEmpty()); // ← أو هنا لو فشل الطلب
      }
    } catch (e, stackTrace) {
      print("Delivery error: $e");
      print("StackTrace: $stackTrace");
      emit(DeliveryError("حدث خطأ غير متوقع"));
    }
  }
}
