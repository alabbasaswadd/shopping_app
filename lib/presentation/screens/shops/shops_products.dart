import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:shopping_app/core/constants/cached/cached_image.dart';
import 'package:shopping_app/core/constants/images.dart';
import 'package:shopping_app/core/constants/colors.dart';
import 'package:shopping_app/core/widgets/my_app_bar.dart';
import 'package:shopping_app/core/widgets/my_text.dart';
import 'package:shopping_app/data/model/shop/shop_data_model.dart';
import 'package:shopping_app/presentation/business_logic/cubit/shop/shop_cubit.dart';
import 'package:shopping_app/presentation/business_logic/cubit/shop/shop_state.dart';

import 'package:shopping_app/presentation/screens/products/product_details.dart';

class ShopProducts extends StatefulWidget {
  const ShopProducts({super.key, required this.shopId});
  static String id = "shopProducts";
  final String shopId;
  @override
  State<ShopProducts> createState() => _CustomContainerProductsState();
}

class _CustomContainerProductsState extends State<ShopProducts> {
  late ShopCubit cubit;
  @override
  void initState() {
    cubit = ShopCubit();
    cubit.getProductsByShopId(widget.shopId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShopCubit, ShopState>(
      bloc: cubit,
      builder: (context, state) {
        if (state is ShopProductsLoading) {
          return const Scaffold(
            body: Center(
              child: SpinKitChasingDots(color: AppColor.kPrimaryColor),
            ),
          );
        } else if (state is ShopProductsLoaded) {
          var products = state.products;
          return Scaffold(
            appBar: myAppBar(
              title: state.shops
                      .firstWhere(
                        (shop) => shop.id == widget.shopId,
                        orElse: () =>
                            ShopDataModel(id: "", firstName: "غير موجود"),
                      )
                      .firstName ??
                  "",
              context: context,
            ),
            body: Padding(
              padding: const EdgeInsets.all(16),
              child: ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, i) {
                  return InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        ProductDetails.id,
                        arguments: products[i],
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      height: 142,
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            offset: const Offset(0, 2),
                            blurRadius: 3,
                          )
                        ],
                        color: Theme.of(context).colorScheme.secondary,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: double.infinity,
                            width: 100,
                            child: CachedImageWidget(
                                imageUrl: products[i].image ?? ""),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: CairoText(products[i].name ?? ""),
                                ),
                                CairoText("${products[i].price} \$"),
                              ],
                            ),
                          ),
                          Column(
                            children: [
                              IconButton(
                                onPressed: () {},
                                icon:
                                    const Icon(Icons.favorite_border_outlined),
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.shopping_cart),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        } else if (state is ShopProductsError) {
          return Scaffold(
            appBar: myAppBar(title: "error".tr, context: context),
            body: Center(
              child: CairoText(
                maxLines: 5,
                "${"error".tr} ${state.error}",
                color: Colors.red,
              ),
            ),
          );
        } else {
          return const Scaffold(
            body: Center(child: CairoText("Unexpected state")),
          );
        }
      },
    );
  }
}
