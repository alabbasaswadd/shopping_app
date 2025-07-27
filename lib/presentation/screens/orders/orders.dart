import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:shopping_app/core/constants/colors.dart';
import 'package:shopping_app/core/constants/const.dart';
import 'package:shopping_app/core/widgets/my_alert_dialog.dart';
import 'package:shopping_app/core/widgets/my_animation.dart';
import 'package:shopping_app/core/widgets/my_app_bar.dart';
import 'package:shopping_app/core/widgets/my_card.dart';
import 'package:shopping_app/core/widgets/my_snackbar.dart';
import 'package:shopping_app/core/widgets/my_text.dart';
import 'package:shopping_app/presentation/business_logic/cubit/order/order_cubit.dart';
import 'package:shopping_app/presentation/business_logic/cubit/order/order_state.dart';
import 'package:intl/intl.dart';
import 'package:shopping_app/presentation/business_logic/cubit/shop/shop_cubit.dart';
import 'package:shopping_app/presentation/screens/orders/order_details.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});
  static String id = "orders";

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  late OrderCubit cubit;
  @override
  void initState() {
    cubit = OrderCubit();
    cubit.getOrders();
    cubit.startWatchingOrders();
    super.initState();
  }

  @override
  void dispose() {
    cubit.stopWatchingOrders();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OrderCubit, OrderState>(
      bloc: cubit,
      listener: (context, state) {
        if (state is OrderDeleted) {
          MySnackbar.showSuccess(context, "تم حذف الطلب بنجاح ");
        }
      },
      builder: (context, state) {
        return BlocBuilder<OrderCubit, OrderState>(
          bloc: cubit,
          builder: (context, state) {
            if (state is OrderLoading) {
              return Scaffold(
                appBar: myAppBar(title: "orders".tr, context: context),
                body: Center(
                  child: SpinKitChasingDots(color: AppColor.kPrimaryColor),
                ),
              );
            } else if (state is OrderEmpty) {
              return Scaffold(
                appBar: myAppBar(title: "orders".tr, context: context),
                body: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.grid_4x4,
                          size: 80, color: Colors.grey.withOpacity(0.5)),
                      SizedBox(height: 20),
                      CairoText("لا يوجد طلبات".tr),
                    ],
                  ),
                ),
              );
            } else if (state is OrderLoaded) {
              return Scaffold(
                  appBar: myAppBar(title: "orders".tr, context: context),
                  body: ListView.builder(
                    itemCount: state.orders.length,
                    itemBuilder: (context, index) {
                      final order = state.orders[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        child: Dismissible(
                          key: ValueKey(order.id),
                          direction: DismissDirection.startToEnd,
                          background: Container(
                            alignment: Alignment.centerRight,
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                              color: Colors.redAccent,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Icon(Icons.delete, color: Colors.white),
                          ),
                          confirmDismiss: (_) async {
                            bool confirm = false;
                            await showDialog(
                              context: context,
                              builder: (_) => MyAlertDialog(
                                title: "إزالة الطلب",
                                content: "هل تريد حذف هذا الطلب؟",
                                onOk: () {
                                  confirm = true;
                                  Get.back();
                                },
                                onNo: Get.back,
                              ),
                            );
                            return confirm;
                          },
                          onDismissed: (_) {
                            cubit.deleteOrder(order.id ?? "");
                          },
                          child: MyAnimation(
                            child: InkWell(
                              onTap: () {
                                Get.to(OrderDetails(order: order));
                                print(order.shop?.firstName);
                                print(order.shop);
                              },
                              child: MyCard(
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // Header with order number and status
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          CairoText(
                                            "الطلب #${order.totalAmount}",
                                            color: Colors.black87,
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 16),

                                      // Order details in a beautiful layout
                                      Row(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                              color: Colors.blue[50],
                                              shape: BoxShape.circle,
                                            ),
                                            child: Icon(Icons.store,
                                                color: Colors.blue[700],
                                                size: 20),
                                          ),
                                          SizedBox(width: 12),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                CairoText(
                                                  "المتجر",
                                                  color: Colors.grey[600],
                                                ),
                                                CairoText(
                                                    '${order.shop?.firstName ?? "غير"} ${order.shop?.lastName ?? "معروف"}'),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 12),
                                      Row(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                              color: Colors.orange[50],
                                              shape: BoxShape.circle,
                                            ),
                                            child: Icon(Icons.access_time,
                                                color: Colors.orange[700],
                                                size: 20),
                                          ),
                                          SizedBox(width: 12),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                CairoText(
                                                  "تاريخ الطلب",
                                                  color: Colors.grey[600],
                                                ),
                                                CairoText(formatDateString(order
                                                    .orderDate
                                                    .toString())),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 16),
                                      Divider(
                                        height: 1,
                                        thickness: 1,
                                        color: Colors.grey[200],
                                      ),
                                      SizedBox(height: 12),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          CairoText("الإجمالي",
                                              color: Colors.grey[600]),
                                          CairoText(
                                            "${order.totalAmount?.toStringAsFixed(2) ?? "0.00"} ر.س",
                                            color: AppColor.kPrimaryColor,
                                          ),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 12, vertical: 6),
                                            decoration: BoxDecoration(
                                              color: getStatusColor(
                                                  order.orderState),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              gradient: getStatusGradient(
                                                  order.orderState),
                                            ),
                                            child: CairoText(
                                              order.orderState?.name ??
                                                  "غير معروف",
                                              color: Colors.white,
                                              fontSize: 11,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ));
            } else if (state is OrderError) {
              return Center(
                  child: CairoText(
                state.error,
                maxLines: 5,
              ));
            } else {
              return Center(
                child: CairoText("Error"),
              );
            }
          },
        );
      },
    );
  }

  String formatDateString(String? rawDate) {
    if (rawDate == null || rawDate.isEmpty) return '';

    try {
      final utcDate = DateTime.parse(rawDate);
      final formatter =
          DateFormat('d MMMM yyyy - hh:mm:ss a', 'ar'); // 12 ساعة مع AM/PM
      return formatter.format(utcDate);
    } catch (e) {
      return '';
    }
  }

  LinearGradient getStatusGradient(OrderStateEnum? status) {
    switch (status) {
      case OrderStateEnum.pending: // جاري المعالجة
        return LinearGradient(colors: [Colors.blue[300]!, Colors.blue[600]!]);
      case OrderStateEnum.scheduled: // تم الجدولة
        return LinearGradient(colors: [Colors.teal[300]!, Colors.teal[600]!]);
      case OrderStateEnum.inTransit: // جاري التوصيل
        return LinearGradient(
            colors: [Colors.orange[300]!, Colors.orange[600]!]);
      case OrderStateEnum.delivered: // تم التوصيل
        return LinearGradient(colors: [Colors.green[400]!, Colors.green[600]!]);
      case OrderStateEnum.cancelled: // تم الإلغاء
        return LinearGradient(colors: [Colors.red[300]!, Colors.red[600]!]);
      case OrderStateEnum.failed: // فشل التوصيل
        return LinearGradient(colors: [Colors.grey[400]!, Colors.grey[700]!]);
      default:
        return LinearGradient(colors: [Colors.grey[400]!, Colors.grey[600]!]);
    }
  }

  Color getStatusColor(OrderStateEnum? status) {
    switch (status) {
      case OrderStateEnum.pending:
        return Colors.blue;
      case OrderStateEnum.scheduled:
        return Colors.teal;
      case OrderStateEnum.inTransit:
        return Colors.orange;
      case OrderStateEnum.delivered:
        return Colors.green;
      case OrderStateEnum.cancelled:
        return Colors.red;
      case OrderStateEnum.failed:
        return Colors.grey;
      default:
        return Colors.grey;
    }
  }
}
