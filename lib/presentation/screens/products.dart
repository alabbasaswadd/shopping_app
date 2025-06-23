import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/presentation/business_logic/cubit/products/products_cubit.dart';
import 'package:shopping_app/data/repository/products_repository.dart';
import 'package:shopping_app/data/web_services/web_services.dart';
import 'package:shopping_app/presentation/widget/products/appbar/products_appbar_actions.dart';
import 'package:shopping_app/presentation/widget/products/appbar/products_drawer.dart';
import 'package:shopping_app/presentation/widget/products/appbar/products_appbar_title.dart';
import 'package:shopping_app/presentation/widget/products/products_body.dart';

class Productes extends StatelessWidget {
  const Productes({super.key});
  static String id = "products";

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => ProductsCubit(Repository(WebServices())),
        child: Scaffold(
            drawer: ProductsDrawer(),
            appBar: AppBar(
              elevation: 8,
              shadowColor: Colors.black,
              title: ProductsAppbarTitle(),
              actions: const [ProductsAppbarActions()],
            ),
            body:
                Container(padding: EdgeInsets.all(20), child: ProductsBody())));
  }
}
