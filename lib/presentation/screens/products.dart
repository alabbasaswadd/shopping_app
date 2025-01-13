import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/business_logic/cubit/products/products_cubit.dart';
import 'package:shopping_app/data/repository/products_repository.dart';
import 'package:shopping_app/data/web_services/products_web_services.dart';
import 'package:shopping_app/presentation/screens/about.dart';
import 'package:shopping_app/presentation/screens/account.dart';
import 'package:shopping_app/presentation/screens/favorite.dart';
import 'package:shopping_app/presentation/screens/login.dart';
import 'package:shopping_app/presentation/screens/orders.dart';
import 'package:shopping_app/presentation/screens/settings.dart';
import 'package:shopping_app/presentation/widget/products/appbar/custom_actions_appbar_products.dart';
import 'package:shopping_app/presentation/widget/products/appbar/custom_title_appbar_products.dart';
import 'package:shopping_app/presentation/widget/products/custom_container_products.dart';
import 'package:shopping_app/presentation/widget/products/custom_drawer_item.dart';
import 'package:shopping_app/presentation/widget/settings/custom_alert_dialog_settings.dart';

class Productes extends StatelessWidget {
  const Productes({super.key});
  static String id = "products";

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) =>
            ProductsCubit(ProductsRepository(ProductsWebServices())),
        child: Scaffold(
            drawer: Drawer(
              child: ListView(
                children: [
                  Image.asset("assets/images/logo2.jpeg", height: 150),
                  Divider(),
                  CustomDrawerItem(
                    icon: Icons.person,
                    title: "Account",
                    ontap: () {
                      Navigator.of(context).pushNamed(Account.id);
                    },
                  ),
                  CustomDrawerItem(
                      icon: Icons.favorite,
                      title: "Favorite",
                      ontap: () {
                        Navigator.of(context).pushNamed(Favorite.id);
                      }),
                  CustomDrawerItem(
                      icon: Icons.wallet_giftcard_rounded,
                      title: "orders",
                      ontap: () {
                        Navigator.of(context).pushNamed(Orders.id);
                      }),
                  CustomDrawerItem(
                      icon: Icons.settings,
                      title: "Settings",
                      ontap: () {
                        Navigator.of(context).pushNamed(Settings.id);
                      }),
                  CustomDrawerItem(
                      icon: Icons.info,
                      title: "About",
                      ontap: () {
                        Navigator.of(context).pushNamed(About.id);
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
                                    Navigator.of(context).pushNamed(Login.id);
                                  },
                                  onNo: () {
                                    Navigator.pop(context);
                                  },
                                ));
                      }),
                ],
              ),
            ),
            appBar: AppBar(
              elevation: 8,
              shadowColor: Colors.grey,
              title: CustomTitleAppbarProducts(),
              actions: [CustomActionsAppbarProducts()],
            ),
            body: Container(
                padding: EdgeInsets.all(20),
                child: CustomContainerProducts())));
  }
}
