import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:get/instance_manager.dart';
import 'package:shopping_app/core/constants/colors.dart';
import 'package:shopping_app/core/widgets/my_animation.dart';
import 'package:shopping_app/core/widgets/my_app_bar.dart';
import 'package:shopping_app/core/widgets/my_card.dart';
import 'package:shopping_app/core/widgets/my_snackbar.dart';
import 'package:shopping_app/presentation/business_logic/cubit/order/order_cubit.dart';
import 'package:shopping_app/presentation/business_logic/cubit/order/order_state.dart';
import 'package:intl/intl.dart';
import 'package:shopping_app/presentation/screens/orders/edit_order.dart';

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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OrderCubit, OrderState>(
      bloc: cubit,
      listener: (context, state) {
        if (state is OrderDeleted) {
          MySnackbar.showSuccess(context, "تم حذذف الطلب بنجاح ");
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
                      Text("لا يوجد طلبات".tr),
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
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 2,
                                blurRadius: 8,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: MyAnimation(
                            child: MyCard(
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Header with order number and status
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "الطلب #${order.totalAmount}",
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black87,
                                          ),
                                        ),
                                        IconButton(
                                            onPressed: () {
                                              print(order.id);
                                              cubit.deleteOrder(order.id ?? "");
                                            },
                                            icon: Icon(Icons.delete,
                                                color: Colors.red)),
                                      ],
                                    ),

                                    SizedBox(height: 16),

                                    // Order details in a beautiful layout
                                    Row(
                                      children: [
                                        // Icon with background
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
                                              Text(
                                                "المتجر",
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.grey[600],
                                                ),
                                              ),
                                              Text(
                                                order.shopId ?? "غير معروف",
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
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
                                              Text(
                                                "تاريخ الطلب",
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.grey[600],
                                                ),
                                              ),
                                              Text(
                                                _formatDate(DateTime.now()),
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),

                                    SizedBox(height: 16),

                                    // Divider with custom style
                                    Divider(
                                      height: 1,
                                      thickness: 1,
                                      color: Colors.grey[200],
                                    ),

                                    SizedBox(height: 12),

                                    // Footer with total amount and action
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "الإجمالي",
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey[600],
                                          ),
                                        ),
                                        Text(
                                          "${order.totalAmount?.toStringAsFixed(2) ?? "0.00"} ر.س",
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color:
                                                Theme.of(context).primaryColor,
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 12, vertical: 6),
                                          decoration: BoxDecoration(
                                            color: _getStatusColor(
                                                order.orderState),
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            gradient: _getStatusGradient(
                                                order.orderState),
                                          ),
                                          child: Text(
                                            order.orderState ?? "غير معروف",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                            ),
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
                      );
                    },
                  ));
            } else if (state is OrderError) {
              return Text(state.error);
            } else {
              return Center(
                child: Text("Error"),
              );
            }
          },
        );
      },
    );
  }

  String _formatDate(DateTime? date) {
    if (date == null) return "غير معروف";
    return DateFormat('yyyy/MM/dd - hh:mm a').format(date);
  }

  LinearGradient _getStatusGradient(String? status) {
    switch (status?.toLowerCase()) {
      case 'مكتمل':
        return LinearGradient(colors: [Colors.green[400]!, Colors.green[600]!]);
      case 'قيد التنفيذ':
        return LinearGradient(
            colors: [Colors.orange[400]!, Colors.orange[600]!]);
      case 'ملغى':
        return LinearGradient(colors: [Colors.red[400]!, Colors.red[600]!]);
      default:
        return LinearGradient(colors: [Colors.grey[400]!, Colors.grey[600]!]);
    }
  }

  Color _getStatusColor(String? status) {
    switch (status?.toLowerCase()) {
      case 'مكتمل':
        return Colors.green;
      case 'قيد التنفيذ':
        return Colors.orange;
      case 'ملغى':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
