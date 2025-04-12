import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_app/core/widgets/my_alert_dialog.dart';
import 'package:shopping_app/presentation/screens/about.dart';
import 'package:shopping_app/presentation/screens/account.dart';
import 'package:shopping_app/presentation/screens/favorite.dart';
import 'package:shopping_app/presentation/screens/orders.dart';
import 'package:shopping_app/presentation/screens/settings.dart';
import 'package:shopping_app/presentation/screens/signup.dart';
import 'package:shopping_app/presentation/widget/products/products_custom_drawer.dart';

class ProductsDrawer extends StatelessWidget {
  const ProductsDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Image.asset("assets/images/logo2.jpeg", height: 150),
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
                  title: "Log_Out",
                  content: "Do You Have Log Out",
                  onOk: () {
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
