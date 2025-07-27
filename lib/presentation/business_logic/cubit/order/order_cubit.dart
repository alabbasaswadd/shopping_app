import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/data/model/order/order_data_model.dart';
import 'package:shopping_app/data/repository/repository.dart';
import 'package:shopping_app/data/web_services/web_services.dart';
import 'package:shopping_app/presentation/business_logic/cubit/order/order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit() : super(OrderLoading());

  Repository repository = Repository(WebServices());

  Timer? _watchTimer;
  List<OrderDataModel> _lastOrders = [];

  void startWatchingOrders({Duration interval = const Duration(seconds: 10)}) {
    _watchTimer?.cancel();
    _watchTimer = Timer.periodic(interval, (_) async {
      await _checkOrdersUpdate();
    });
  }

  void stopWatchingOrders() {
    _watchTimer?.cancel();
    _watchTimer = null;
  }

  Future<void> _checkOrdersUpdate() async {
    try {
      final response = await repository.getOrdersRepository();
      if (response.statusCode == 200 &&
          response.data != null &&
          response.data['succeeded'] == true) {
        final ordersJson = response.data['data'] as List<dynamic>;
        final currentOrders = ordersJson
            .map((orderJson) => OrderDataModel.fromJson(orderJson))
            .toList();

        bool hasChanged = false;

        if (_lastOrders.length != currentOrders.length) {
          hasChanged = true;
        } else {
          // نقارن حالة كل طلب بناءً على الـ id و orderState
          for (int i = 0; i < currentOrders.length; i++) {
            final oldOrder = _lastOrders.firstWhere(
              (o) => o.id == currentOrders[i].id,
              orElse: () => OrderDataModel(id: null), // طلب جديد
            );
            if (oldOrder.id == null ||
                oldOrder.orderState != currentOrders[i].orderState) {
              hasChanged = true;
              break;
            }
          }
        }

        if (hasChanged) {
          _lastOrders = currentOrders;
          emit(OrderLoaded(currentOrders));
        }
      }
    } catch (e) {
      emit(OrderError("فشل التحقق من الطلبات: $e"));
    }
  }

  /// للحصول على جميع الطلبات
  void getOrders() async {
    try {
      emit(OrderLoading());
      final response = await repository.getOrdersRepository();

      if (response.statusCode == 200 &&
          response.data != null &&
          response.data['succeeded'] == true) {
        final ordersJson = response.data['data'] as List<dynamic>;
        final orders = ordersJson
            .map((orderJson) => OrderDataModel.fromJson(orderJson))
            .toList();

        if (orders.isEmpty) {
          emit(OrderEmpty());
        } else {
          emit(OrderLoaded(orders));
        }
      } else {
        emit(OrderEmpty());
      }
    } catch (e) {
      emit(OrderError("فشل تحميل الطلبات: $e"));
    }
  }

  /// تحديث الطلب - لاحظ أنه الآن يقبل بيانات الطلب
  void updateOrder(String orderId, OrderDataModel updatedData) async {
    try {
      emit(OrderLoading());
      final response =
          await repository.updateOrderRepository(orderId, updatedData);

      if (response.statusCode == 200 &&
          response.data != null &&
          response.data['succeeded'] == true) {
        emit(OrderUpdated(updatedData));
        getOrders(); // يمكن تحديث القائمة
      } else {
        emit(OrderError('فشل تحديث الطلب. الكود: ${response.statusCode}'));
      }
    } catch (e) {
      emit(OrderError("حدث خطأ أثناء تحديث الطلب: $e"));
    }
  }

  /// إضافة طلب
  Future<void> addOrder(OrderDataModel dataOrder) async {
    try {
      emit(OrderLoading());

      final response = await repository.addOrderRepository(dataOrder);

      if (response.statusCode == 200 &&
          response.data != null &&
          response.data['succeeded'] == true) {
        emit(OrderAdded());
      } else {
        emit(OrderError("فشل إرسال الطلب. الكود: ${response.statusCode}"));
      }
    } catch (e) {
      emit(OrderError("حدث خطأ غير متوقع أثناء إرسال الطلب: $e"));
    }
  }

  /// حذف طلب
  void deleteOrder(String orderId) async {
    try {
      emit(OrderLoading());
      final response = await repository.deleteOrderRepository(orderId);

      if (response.statusCode == 200 &&
          response.data != null &&
          response.data['succeeded'] == true) {
        emit(OrderDeleted());
        getOrders();
      } else {
        emit(OrderError('فشل حذف الطلب. الكود: ${response.statusCode}'));
      }
    } catch (e) {
      emit(OrderError('حدث خطأ أثناء حذف الطلب: $e'));
    }
  }
}
