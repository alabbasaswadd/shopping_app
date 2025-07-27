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
import 'package:shopping_app/presentation/business_logic/cubit/order/order_state.dart';
import 'package:shopping_app/presentation/screens/delivery_company.dart';
import 'package:shopping_app/presentation/screens/products/product_details.dart';

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
                  CairoText("no_products_in_card".tr),
                ],
              ),
            ),
          );
        } else if (state is CartLoaded) {
          final cart = state.cart;
          final items = cart.shoppingCartItems;

          return Scaffold(
            appBar: myAppBar(title: "card".tr, context: context, actions: [
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
                              title: "إفراغ السلة",
                              content: "هل تريد إفراغ السلة"));
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
            appBar: myAppBar(title: "card".tr, context: context),
            body: Center(
                child: CairoText(
                    "❌ ${state.error}")), // استخدم state.error بدل message
          );
        } else {
          return Scaffold(
            body: Center(child: CairoText("حدث خطأ غير متوقع")),
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
            title: "إزالة من السلة",
            content: "هل تريد إزالة المنتج من السلة؟",
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
              CairoText("total".tr),
              CairoText(
                "\$${totalPrice.toStringAsFixed(2)}",
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
              return MyAnimation(
                scale: 0.90,
                child: MyButton(
                  isLoading: false,
                  text: "إرسال الطلب",
                  onPressed: () {
                    {
                      showDialog(
                          context: context,
                          builder: (context) => MyAlertDialog(
                              onOk: () async {
                                print(totalPrice);
                                // التحقق من أن كل العناصر تتبع نفس المتجر
                                final firstShopId = items.first.shopId;
                                final allSameShop = items.every(
                                    (item) => item.shopId == firstShopId);
                                if (!allSameShop) {
                                  MySnackbar.showError(context,
                                      "كل المنتجات يجب أن تكون من نفس المتجر");
                                  return;
                                }
                                final order = OrderDataModel(
                                  customerId: UserSession.id,
                                  shopId: firstShopId ?? "",
                                  orderDate:
                                      DateTime.now().toUtc().toIso8601String(),
                                  totalAmount: totalPrice,
                                  orderState: OrderStateEnum.pending,
                                  orderItems: items.map((item) {
                                    return OrderItemsModel(
                                      productId: item.productId,
                                      quantity: item.quantity,
                                      price: item.productPrice,
                                    );
                                  }).toList(),
                                );
                                await orderCubit.addOrder(order);
                                cubit.getCart();
                                Get.back();
                              },
                              onNo: () {
                                Get.back();
                              },
                              title: "إرسال طلب",
                              content: "هل تريد إرسال الطلب"));
                    }
                  },
                ),
              );
            },
          ),
          MyButton(
              color: Colors.green,
              text: "إختيار شركة توصيل",
              onPressed: () {
                Get.toNamed(DeliveryCompanySelection.id);
              })
        ],
      ),
    );
  }
}
