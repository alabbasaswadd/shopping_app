import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:shopping_app/core/constants/colors.dart';
import 'package:shopping_app/core/constants/functions.dart';
import 'package:shopping_app/core/widgets/my_app_bar.dart';
import 'package:shopping_app/core/widgets/my_snackbar.dart';
import 'package:shopping_app/core/widgets/my_text.dart';
import 'package:shopping_app/data/model/cart/add_to_cart_request.dart';
import 'package:shopping_app/data/model/products/product_data_model.dart';
import 'package:shopping_app/presentation/business_logic/cubit/products/products_cubit.dart';
import 'package:shopping_app/presentation/widget/products/products_details_body.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({super.key});
  static String id = "product_details";

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  late ProductsCubit cubit;
  final product = Get.arguments as ProductDataModel;

  @override
  void initState() {
    cubit = ProductsCubit();
    cubit.getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(title: product.name ?? "", context: context),
      body: BlocConsumer<ProductsCubit, ProductsState>(
        bloc: cubit,
        listener: (context, state) {
          if (state is ProductsFeildAdd) {
            MySnackbar.showError(context, "Error: ${state.error}");
          } else if (state is ProductsAdded) {
            MySnackbar.showSuccess(context, "تمت الإضافة");
          }
        },
        builder: (context, state) {
          if (state is ProductsLoading) {
            return const Center(
              child: SpinKitChasingDots(color: AppColor.kPrimaryColor),
            );
          } else if (state is ProductsLoaded) {
            return Padding(
              padding: const EdgeInsets.all(15),
              child: ProductsDetailsBody(product: product), // 👈 تمرير المنتج
            );
          } else {
            return const Center(child: CairoText("Error"));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final request = AddToCartRequest(
            shoppingCartId: UserSession.shoppingCartId ?? "",
            productId: product.id ?? "",
            quantity: 1,
            shopId: product.shopId!,
          );
          cubit.addToCart(request);
        },
        child: const Icon(
          Icons.shopping_cart,
          color: AppColor.kWhiteColor,
        ),
      ),
    );
  }
}
