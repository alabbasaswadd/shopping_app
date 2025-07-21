import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/presentation/business_logic/cubit/products/products_cubit.dart';
import 'package:shopping_app/presentation/business_logic/cubit/searching/searching_cubit.dart';
import 'package:shopping_app/presentation/widget/products/appbar/products_appbar_actions.dart';
import 'package:shopping_app/presentation/widget/products/appbar/products_drawer.dart';
import 'package:shopping_app/presentation/widget/products/appbar/products_appbar_title.dart';
import 'package:shopping_app/presentation/widget/products/products_body.dart';

class Productes extends StatefulWidget {
  const Productes({super.key});
  static String id = "products";

  @override
  State<Productes> createState() => _ProductesState();
}

class _ProductesState extends State<Productes> {
  late SearchingCubit cubit;
  @override
  void initState() {
    cubit = SearchingCubit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProductsCubit>(
          create: (_) => ProductsCubit()..getProducts(),
        ),
        BlocProvider<SearchingCubit>(
          create: (_) => SearchingCubit(),
        ),
      ],
      child: Scaffold(
        drawer: ProductsDrawer(),
        appBar: AppBar(
          elevation: 8,
          shadowColor: Colors.black,
          title: BlocBuilder<SearchingCubit, SearchingState>(
            bloc: cubit,
            builder: (context, state) {
              return ProductsAppbarTitle(cubit: cubit);
            },
          ),
          actions: const [ProductsAppbarActions()],
        ),
        body: const Padding(
          padding: EdgeInsets.all(5),
          child: ProductsBody(),
        ),
      ),
    );
  }
}
