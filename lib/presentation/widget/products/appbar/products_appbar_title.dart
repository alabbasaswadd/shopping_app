import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:shopping_app/presentation/business_logic/cubit/searching/searching_cubit.dart';

class ProductsAppbarTitle extends StatefulWidget {
  const ProductsAppbarTitle({super.key});
  static TextEditingController controller = TextEditingController();

  @override
  State<ProductsAppbarTitle> createState() =>
      _CustomTitleAppbarProductsState();
}

class _CustomTitleAppbarProductsState extends State<ProductsAppbarTitle> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: TextFormField(
        controller: ProductsAppbarTitle.controller,
        onChanged: (query) {
          BlocProvider.of<SearchingCubit>(context).searchProducts(query);
        },
        decoration: InputDecoration(
          filled: true,
          hintText: "search".tr,
          hintStyle: TextStyle(color: Theme.of(context).colorScheme.onSurface),
          border: OutlineInputBorder(borderSide: BorderSide.none),
        ),
      ),
    );
  }
}
