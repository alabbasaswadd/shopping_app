import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_app/presentation/screens/about.dart';
import 'package:shopping_app/presentation/screens/account.dart';
import 'package:shopping_app/presentation/screens/favorite.dart';
import 'package:shopping_app/presentation/screens/orders.dart';
import 'package:shopping_app/presentation/screens/settings.dart';
import 'package:shopping_app/presentation/screens/signup.dart';
import 'package:shopping_app/presentation/widget/products/custom_drawer_item.dart';
import 'package:shopping_app/presentation/widget/settings/custom_alert_dialog_settings.dart';

class CustomDrawerProducts extends StatelessWidget {
  const CustomDrawerProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Image.asset("assets/images/logo2.jpeg", height: 150),
          Divider(),
          CustomDrawerItem(
            icon: Icons.person,
            title: "Account",
            ontap: () {
              Get.toNamed(Account.id);
            },
          ),
          CustomDrawerItem(
              icon: Icons.favorite,
              title: "Favorite",
              ontap: () {
                Get.toNamed(Favorite.id);
              }),
          CustomDrawerItem(
              icon: Icons.wallet_giftcard_rounded,
              title: "orders",
              ontap: () {
                Get.toNamed(Orders.id);
              }),
          CustomDrawerItem(
              icon: Icons.settings,
              title: "Settings",
              ontap: () {
                Get.toNamed(Settings.id);
              }),
          CustomDrawerItem(
              icon: Icons.info,
              title: "About",
              ontap: () {
                Get.toNamed(About.id);
              }),
          CustomDrawerItem(
              icon: Icons.logout,
              title: "LogOut",
              color: Colors.red,
              ontap: () {
                showDialog(
                    context: context,
                    builder: (context) => CustomAlertDialogSettings(
                          onOk: () {
                            Get.offAllNamed(SignUp.id);
                          },
                          onNo: () {
                            Get.back();
                          },
                        ));
              }),
        ],
      ),
    );
  }
}
