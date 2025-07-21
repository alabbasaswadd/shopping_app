import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:shopping_app/presentation/business_logic/cubit/searching/searching_cubit.dart';

class ProductsAppbarTitle extends StatefulWidget {
  final SearchingCubit cubit;
  const ProductsAppbarTitle({required this.cubit, super.key});

  @override
  State<ProductsAppbarTitle> createState() => _CustomTitleAppbarProductsState();
}

class _CustomTitleAppbarProductsState extends State<ProductsAppbarTitle> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: TextFormField(
        onChanged: (query) {
          widget.cubit.searchProducts(query);
        },
        decoration: InputDecoration(
          filled: true,
          hintText: "search".tr,
          border: OutlineInputBorder(borderSide: BorderSide.none),
        ),
      ),
    );
  }
}
