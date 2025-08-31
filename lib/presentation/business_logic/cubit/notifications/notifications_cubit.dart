import 'package:bloc/bloc.dart';
import 'package:shopping_app/data/model/notifications/notifications_data_model.dart';
import 'package:shopping_app/data/repository/repository.dart';
import 'package:shopping_app/data/web_services/web_services.dart';
import 'package:shopping_app/presentation/business_logic/cubit/notifications/notifications_state.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  NotificationsCubit() : super(NotificationsLoading());
  Repository repository = Repository(WebServices());
  void getNotifications() async {
    try {
      emit(NotificationsLoading());

      final response = await repository.getNotificationsRepository();

      if (response.statusCode == 200 &&
          response.data != null &&
          response.data['succeeded'] == true) {
        final dataList = response.data['data'] as List;

        final notifications = dataList
            .map((e) => NotificationsModel.fromJson(e as Map<String, dynamic>))
            .toList();

        if (notifications.isNotEmpty) {
          emit(NotificationsLoaded(notifications));
        } else {
          emit(NotificationsEmpty()); // ← ستصل هنا إذا كانت القائمة فاضية
        }
      } else {
        emit(NotificationsError(
            "حدث خطأ أثناء جلب الإشعارات")); // ← لو فشل الطلب
      }
    } catch (e, stackTrace) {
      print("Delivery error: $e");
      print("StackTrace: $stackTrace");
      emit(NotificationsError("حدث خطأ غير متوقع"));
    }
  }
}
