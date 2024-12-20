import 'package:flutter/material.dart';
import 'package:shopping_app/core/constants/colors.dart';
import 'package:shopping_app/view/widget/products/appbar/custom_actions_appbar_products.dart';
import 'package:shopping_app/view/widget/products/appbar/custom_title_appbar_products.dart';
import 'package:shopping_app/view/widget/products/custom_container_products.dart';

class Productes extends StatelessWidget {
  const Productes({super.key});
  static String id = "products";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(),
        appBar: AppBar(
          elevation: 8,
          shadowColor: Colors.grey,
          title: CustomTitleAppbarProducts(),
          actions: [CustomActionsAppbarProducts()],
        ),
        body: Container(
            padding: EdgeInsets.all(20), child: CustomContainerProducts()));
  }
}
