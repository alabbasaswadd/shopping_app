import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:shopping_app/core/constants/colors.dart';
import 'package:shopping_app/core/constants/functions.dart';
import 'package:shopping_app/core/widgets/my_alert_dialog.dart';
import 'package:shopping_app/core/widgets/my_app_bar.dart';
import 'package:shopping_app/core/widgets/my_button.dart';
import 'package:shopping_app/core/widgets/my_card.dart';
import 'package:shopping_app/core/widgets/my_snackbar.dart';
import 'package:shopping_app/data/model/cart/shopping_cart_items_model.dart';
import 'package:shopping_app/data/model/order/order_data_model.dart';
import 'package:shopping_app/data/model/order/order_items_model.dart';
import 'package:shopping_app/presentation/business_logic/cubit/cart/cart_cubit.dart';
import 'package:shopping_app/presentation/business_logic/cubit/cart/cart_state.dart';
import 'package:shopping_app/presentation/business_logic/cubit/order/order_cubit.dart';
import 'package:shopping_app/presentation/business_logic/cubit/order/order_state.dart';
import 'package:shopping_app/presentation/business_logic/cubit/products/products_cubit.dart';

class CardPage extends StatefulWidget {
  const CardPage({super.key});
  static String id = "cart";

  @override
  State<CardPage> createState() => _CartPageState();
}

class _CartPageState extends State<CardPage> {
  late CartCubit cubit;
  late OrderCubit orderCubit;
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    orderCubit = OrderCubit();
    cubit = CartCubit();
    cubit.getCart();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartCubit, CartState>(
      bloc: cubit,
      listener: (context, state) {
        // يمكنك إضافة منطق الاستماع هنا إذا لزم الأمر
        // مثال: إظهار Snackbar عند حذف منتج أو حدوث خطأ
        if (state is ProductDeleted) {
          MySnackbar.showSuccess(context, "تم حذف المنتج");
        }
        if (state is CleanCart) {
          MySnackbar.showSuccess(context, "تم إفراغ السلة");
        }
      },
      builder: (context, state) {
        if (state is CartLoading) {
          return Scaffold(
            appBar: myAppBar(title: "card".tr, context: context),
            body: Center(
              child: SpinKitChasingDots(color: AppColor.kPrimaryColor),
            ),
          );
        } else if (state is EmptyCart) {
          return Scaffold(
            appBar: myAppBar(title: "card".tr, context: context),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.shopping_cart_outlined,
                      size: 80, color: Colors.grey.withOpacity(0.5)),
                  SizedBox(height: 20),
                  Text("no_products_in_card".tr),
                ],
              ),
            ),
          );
        } else if (state is CartLoaded) {
          final cart = state.cart;
          final items = cart.shoppingCartItems;

          return Scaffold(
            appBar: myAppBar(title: "card".tr, context: context, actions: [
              IconButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) => MyAlertDialog(
                            onOk: () {
                              cubit.clearCart(UserSession.id ?? "");
                              Get.back();
                            },
                            onNo: () {
                              Get.back();
                            },
                            title: "إفراغ السلة",
                            content: "هل تريد إفراغ السلة"));
                  },
                  icon: Icon(
                    Icons.delete,
                    color: Colors.white,
                  ))
            ]),
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.all(16),
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      return _buildCartItem(items[index], index);
                    },
                  ),
                ),
                _buildCheckoutSection(items),
              ],
            ),
          );
        } else if (state is CartError) {
          return Scaffold(
            appBar: myAppBar(title: "card".tr, context: context),
            body: Center(
                child:
                    Text("❌ ${state.error}")), // استخدم state.error بدل message
          );
        } else {
          return Scaffold(
            body: Center(child: Text("حدث خطأ غير متوقع")),
          );
        }
      },
    );
  }

  Widget _buildCartItem(ShoppingCartItemsModel item, int index) {
    return MyCard(
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Row(
          children: [
            // صورة المنتج
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                item.productImage ?? "",
                width: 80,
                height: 80,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    Icon(Icons.image_not_supported),
              ),
            ),
            SizedBox(width: 12),

            // معلومات المنتج
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.productName ?? ''),
                  SizedBox(height: 4),
                  Text("\$${(item.productPrice ?? 0).toStringAsFixed(2)}"),
                ],
              ),
            ),

            // أدوات التحكم بالكمية
            Column(
              children: [
                IconButton(
                  icon: Icon(Icons.close, size: 20),
                  onPressed: () {
                    cubit.deleteProductFromCart(item.id ?? "");
                  },
                  color: Colors.red,
                  padding: EdgeInsets.zero,
                  constraints: BoxConstraints(),
                ),
                SizedBox(height: 8),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove, size: 16),
                        onPressed: () {
                          setState(() {
                            item.quantity = item.quantity! - 1;
                          });
                        },
                        padding: EdgeInsets.zero,
                        constraints: BoxConstraints(),
                      ),
                      Text("${item.quantity}", style: TextStyle(fontSize: 14)),
                      IconButton(
                        icon: Icon(Icons.add, size: 16),
                        onPressed: () {
                          setState(() {
                            item.quantity = item.quantity! + 1;
                          });
                        },
                        padding: EdgeInsets.zero,
                        constraints: BoxConstraints(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCheckoutSection(List<ShoppingCartItemsModel> items) {
    final totalPrice = items.fold<double>(
      0.0,
      (sum, item) => sum + ((item.quantity ?? 0) * (item.productPrice ?? 0)),
    );

    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, -5),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "total".tr,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                "\$${totalPrice.toStringAsFixed(2)}",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColor.kPrimaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          BlocConsumer<OrderCubit, OrderState>(
            bloc: orderCubit,
            listener: (context, state) {
              if (state is OrderAdded) {
                MySnackbar.showSuccess(context, "تم إرسال الطلب بنجاح");
              } else if (state is OrderError) {
                MySnackbar.showError(
                    context, "فشل إرسال الطلب: ${state.error}");
              }
            },
            builder: (context, state) {
              return MyButton(
                isLoading: false,
                text: "إرسال الطلب",
                onPressed: () {
                  if (items.isEmpty) {
                    MySnackbar.showError(context, "السلة فارغة!");
                    return;
                  }
                  // التحقق من أن كل العناصر تتبع نفس المتجر
                  final firstShopId = items.first.shopId;
                  final allSameShop =
                      items.every((item) => item.shopId == firstShopId);
                  print(items.first.toJson());
                  print(firstShopId);
                  if (!allSameShop) {
                    MySnackbar.showError(
                        context, "كل المنتجات يجب أن تكون من نفس المتجر");
                    return;
                  }

                  final order = OrderDataModel(
                    customerId: UserSession.id,
                    shopId: firstShopId ?? "",
                    orderDate: DateTime.now().toUtc().toIso8601String(),
                    totalAmount: items.fold<int>(
                      0,
                      (sum, item) =>
                          sum +
                          ((item.quantity ?? 0) * (item.productPrice ?? 0)),
                    ),
                    orderState: "قيد التنفيذ",
                    orderItems: items.map((item) {
                      return OrderItemsModel(
                        productId: item.productId,
                        quantity: item.quantity,
                        price: item.productPrice,
                      );
                    }).toList(),
                  );
                  print(order.toJson());
                  orderCubit.addOrder(order);
                },
              );
            },
          )
        ],
      ),
    );
  }
}
