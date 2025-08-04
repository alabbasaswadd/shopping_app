import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:shopping_app/core/constants/cached/cached_image.dart';
import 'package:shopping_app/core/constants/colors.dart';
import 'package:shopping_app/core/constants/const.dart';
import 'package:shopping_app/core/constants/functions.dart';
import 'package:shopping_app/core/widgets/my_alert_dialog.dart';
import 'package:shopping_app/core/widgets/my_animation.dart';
import 'package:shopping_app/core/widgets/my_app_bar.dart';
import 'package:shopping_app/core/widgets/my_button.dart';
import 'package:shopping_app/core/widgets/my_card.dart';
import 'package:shopping_app/core/widgets/my_snackbar.dart';
import 'package:shopping_app/core/widgets/my_text.dart';
import 'package:shopping_app/data/model/cart/shopping_cart_items_model.dart';
import 'package:shopping_app/data/model/order/order_data_model.dart';
import 'package:shopping_app/data/model/order/order_items_model.dart';
import 'package:shopping_app/presentation/business_logic/cubit/cart/cart_cubit.dart';
import 'package:shopping_app/presentation/business_logic/cubit/cart/cart_state.dart';
import 'package:shopping_app/presentation/business_logic/cubit/order/order_cubit.dart';
import 'package:shopping_app/presentation/screens/orders/order_details.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});
  static String id = "cart";

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
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
        if (state is ProductDeleted) {
          MySnackbar.showSuccess(context, "product_deleted".tr);
        }
        if (state is CleanCart) {
          MySnackbar.showSuccess(context, "cart_cleared".tr);
        }
      },
      builder: (context, state) {
        if (state is CartLoading) {
          return Scaffold(
            appBar: myAppBar(title: "cart".tr, context: context),
            body: Center(
              child: SpinKitChasingDots(color: AppColor.kPrimaryColor),
            ),
          );
        } else if (state is EmptyCart) {
          return Scaffold(
            appBar: myAppBar(title: "cart".tr, context: context),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.shopping_cart_outlined,
                      size: 80, color: Colors.grey.withOpacity(0.5)),
                  SizedBox(height: 20),
                  CairoText("no_products_in_card".tr),
                ],
              ),
            ),
          );
        } else if (state is CartLoaded) {
          final cart = state.cart;
          final items = cart.shoppingCartItems;

          return Scaffold(
            appBar: myAppBar(title: "cart".tr, context: context, actions: [
              MyAnimation(
                scale: 0.7,
                child: IconButton(
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
                              title: "cart_cleared".tr,
                              content: "product_deleted".tr));
                    },
                    icon: Icon(
                      Icons.delete,
                      color: Colors.white,
                    )),
              )
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
            appBar: myAppBar(title: "cart".tr, context: context),
            body: Center(
                child: CairoText(
                    "❌ ${state.error}")), // استخدم state.error بدل message
          );
        } else {
          return Scaffold(
            body: Center(child: CairoText("unexpected_error".tr)),
          );
        }
      },
    );
  }

  Widget _buildCartItem(ShoppingCartItemsModel item, int index) {
    return Dismissible(
      key: ValueKey(item.id), // يجب أن يكون فريدًا
      direction: DismissDirection.startToEnd, // السحب من اليمين لليسار
      background: Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.symmetric(horizontal: 20),
        color: Colors.redAccent,
        child: Icon(Icons.delete, color: Colors.white),
      ),
      confirmDismiss: (direction) async {
        // تأكيد الحذف إذا أردت
        bool confirm = false;
        await showDialog(
          context: context,
          builder: (_) => MyAlertDialog(
            title: "remove_from_cart".tr,
            content: "remove_product_confirm".tr,
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
        cubit.deleteProductFromCart(item.id ?? "");
      },
      child: MyCard(
        padding: EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // صورة المنتج
            ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: CachedImageWidget(
                imageUrl: item.productImage ?? '',
                heightRatio: 178,
                widthRatio: 178,
                memCacheHeight: (0.15.sh).toInt(),
                memCacheWidth: (0.15.sh).toInt(),
              ),
            ),
            SizedBox(width: 12.w),

            // معلومات المنتج
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CairoText(
                    item.productName ?? '',
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4.h),
                  CairoText("\$${(item.productPrice ?? 0).toStringAsFixed(2)}",
                      fontSize: 13.sp, color: AppColor.kPrimaryColor),
                  SizedBox(height: 12.h),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove, size: 18),
                        onPressed: () {
                          setState(() {
                            if (item.quantity! > 1) {
                              item.quantity = item.quantity! - 1;
                            }
                          });
                        },
                      ),
                      Container(
                        width: 40.w,
                        height: 30.h,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: CairoText("${item.quantity}"),
                      ),
                      IconButton(
                        icon: Icon(Icons.add, size: 18),
                        onPressed: () {
                          setState(() {
                            item.quantity = item.quantity! + 1;
                          });
                        },
                      ),
                      Spacer(),
                      // زر الحذف اليدوي (اختياري)
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCheckoutSection(List<ShoppingCartItemsModel> items) {
    final totalPrice = items.fold<double>(
      0,
      (sum, item) => sum + ((item.quantity ?? 0) * (item.productPrice ?? 0)),
    );
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onSurface == Colors.white
            ? AppColor.kSecondColorDarkMode.withOpacity(0.5)
            : Colors.white,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CairoText("total".tr),
              CairoText(
                "\$${totalPrice.toStringAsFixed(2)}",
              ),
            ],
          ),
          SizedBox(height: 16),
          MyAnimation(
            scale: 0.90,
            child: MyButton(
              isLoading: false,
              text: "continue_order_title".tr,
              onPressed: () {
                {
                  showDialog(
                      context: context,
                      builder: (context) => MyAlertDialog(
                          onOk: () {
                            final firstShopId = items.first.shopId;
                            final order = OrderDataModel(
                              customerId: UserSession.id,
                              shopId: firstShopId ?? "",
                              orderDate:
                                  DateTime.now().toUtc().toIso8601String(),
                              totalAmount: totalPrice,
                              orderState: OrderStateEnum.pending,
                              noteDelivery: "as",
                              deliveryCompanyId: "",
                              orderItems: items.map((item) {
                                return OrderItemsModel(
                                  id: "",
                                  orderId: "",
                                  productName: item.productName,
                                  productId: item.productId,
                                  quantity: item.quantity,
                                  price: item.productPrice ?? 0,
                                );
                              }).toList(),
                            );
                            Get.back();
                            Get.to(OrderDetails(order: order));
                          },
                          onNo: () {
                            Get.back();
                          },
                          title: "continue_order_title".tr,
                          content: "continue_order_content".tr));
                }
              },
            ),
          ),
          // BlocConsumer<OrderCubit, OrderState>(
          //   bloc: orderCubit,
          //   listener: (context, state) {
          //     if (state is OrderAdded) {
          //       MySnackbar.showSuccess(context, "تم إرسال الطلب بنجاح");
          //     } else if (state is OrderError) {
          //       MySnackbar.showError(
          //           context, "فشل إرسال الطلب: ${state.error}");
          //     }
          //   },
          //   builder: (context, state) {
          //     return MyAnimation(
          //       scale: 0.90,
          //       child: MyButton(
          //         isLoading: false,
          //         text: "إرسال الطلب",
          //         onPressed: () {
          //           {
          //             showDialog(
          //                 context: context,
          //                 builder: (context) => MyAlertDialog(
          //                     onOk: () async {
          //                       print(totalPrice);
          //                       // التحقق من أن كل العناصر تتبع نفس المتجر
          //                       final firstShopId = items.first.shopId;
          //                       final allSameShop = items.every(
          //                           (item) => item.shopId == firstShopId);
          //                       if (!allSameShop) {
          //                         MySnackbar.showError(context,
          //                             "كل المنتجات يجب أن تكون من نفس المتجر");
          //                         return;
          //                       }
          //                       final order = OrderDataModel(
          //                         id: "",
          //                         shop: ShopDataModel(),
          //                         noteDelivery: "جيبهن عالبيت",
          //                         deliveryCompanyId:
          //                             "c572a3c6-2ab7-49cb-56ed-08ddcd14c82e",
          //                         customerId: UserSession.id,
          //                         shopId: firstShopId ?? "",
          //                         orderDate:
          //                             DateTime.now().toUtc().toIso8601String(),
          //                         totalAmount: totalPrice,
          //                         orderState: OrderStateEnum.pending,
          //                         orderItems: items.map((item) {
          //                           return OrderItemsModel(
          //                             productId: item.productId,
          //                             quantity: item.quantity,
          //                             price: item.productPrice,
          //                           );
          //                         }).toList(),
          //                       );
          //                       await orderCubit.addOrder(order);
          //                       cubit.getCart();
          //                       Get.back();
          //                     },
          //                     onNo: () {
          //                       Get.back();
          //                     },
          //                     title: "إرسال طلب",
          //                     content: "هل تريد إرسال الطلب"));
          //           }
          //         },
          //       ),
          //     );
          //   },
          // ),
        ],
      ),
    );
  }
}
