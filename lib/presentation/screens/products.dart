import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/business_logic/cubit/products/products_cubit.dart';
import 'package:shopping_app/data/repository/products_repository.dart';
import 'package:shopping_app/data/web_services/products_web_services.dart';
import 'package:shopping_app/presentation/widget/products/appbar/custom_actions_appbar_products.dart';
import 'package:shopping_app/presentation/widget/products/appbar/custom_drawer_products.dart';
import 'package:shopping_app/presentation/widget/products/appbar/custom_title_appbar_products.dart';
import 'package:shopping_app/presentation/widget/products/custom_container_products.dart';

class Productes extends StatelessWidget {
  const Productes({super.key});
  static String id = "products";

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) =>
            ProductsCubit(ProductsRepository(ProductsWebServices())),
        child: Scaffold(
            drawer: CustomDrawerProducts(),
            appBar: AppBar(
              elevation: 8,
              shadowColor: Colors.black,
              title: CustomTitleAppbarProducts(),
              actions: const [CustomActionsAppbarProducts()],
            ),
            body: Container(
                padding: EdgeInsets.all(20),
                child: CustomContainerProducts())));
  }
}
