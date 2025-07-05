import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_app/core/constants/functions.dart';
import 'package:shopping_app/core/constants/images.dart';
import 'package:shopping_app/core/widgets/my_alert_dialog.dart';
import 'package:shopping_app/presentation/business_logic/cubit/auth/auth_cubit.dart';
import 'package:shopping_app/presentation/screens/about.dart';
import 'package:shopping_app/presentation/screens/account.dart';
import 'package:shopping_app/presentation/screens/change_password_screen.dart';
import 'package:shopping_app/presentation/screens/favorite.dart';
import 'package:shopping_app/presentation/screens/orders/orders.dart';
import 'package:shopping_app/presentation/screens/settings.dart';
import 'package:shopping_app/presentation/screens/auth/signup.dart';
import 'package:shopping_app/presentation/widget/products/products_custom_drawer.dart';

class ProductsDrawer extends StatefulWidget {
  const ProductsDrawer({super.key});

  @override
  State<ProductsDrawer> createState() => _ProductsDrawerState();
}

class _ProductsDrawerState extends State<ProductsDrawer> {
  late AuthCubit cubit;
  @override
  void initState() {
    cubit = AuthCubit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Image.asset(AppImages.klogo, height: 150),
          const Divider(),
          ProductsCustomDrawer(
            icon: Icons.person,
            title: "account".tr,
            ontap: () {
              Get.toNamed(Account.id);
            },
          ),
          ProductsCustomDrawer(
            icon: Icons.favorite,
            title: "favorite".tr,
            ontap: () {
              Get.toNamed(Favorite.id);
            },
          ),
          ProductsCustomDrawer(
            icon: Icons.wallet_giftcard_rounded,
            title: "orders".tr,
            ontap: () {
              Get.toNamed(Orders.id);
            },
          ),
          ProductsCustomDrawer(
            icon: Icons.lock_outline,
            title: "change_password".tr,
            ontap: () {
              Get.toNamed(ChangePasswordScreen.id);
            },
          ),
          ProductsCustomDrawer(
            icon: Icons.settings,
            title: "settings".tr,
            ontap: () {
              Get.toNamed(Settings.id);
            },
          ),
          ProductsCustomDrawer(
            icon: Icons.info,
            title: "about".tr,
            ontap: () {
              Get.toNamed(About.id);
            },
          ),
          ProductsCustomDrawer(
            icon: Icons.logout,
            title: "log_out".tr,
            color: Colors.red,
            ontap: () {
              showDialog(
                context: context,
                builder: (context) => MyAlertDialog(
                  title: "log_out".tr,
                  content: "do_you_want_to_log_out".tr,
                  onOk: () {
                    UserSession.clear();
                    cubit.logout();
                    Get.offAllNamed(SignUp.id);
                  },
                  onNo: () {
                    Get.back();
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
