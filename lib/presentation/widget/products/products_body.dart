import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shopping_app/core/constants/functions.dart';
import 'package:shopping_app/core/constants/images.dart';
import 'package:shopping_app/core/widgets/my_snackbar.dart';
import 'package:shopping_app/data/model/cart/add_to_cart_request.dart';
import 'package:shopping_app/presentation/business_logic/cubit/products/products_cubit.dart';
import 'package:shopping_app/core/constants/colors.dart';
import 'package:shopping_app/presentation/screens/products/product_details.dart';

class ProductsBody extends StatefulWidget {
  const ProductsBody({super.key});

  @override
  State<ProductsBody> createState() => _CustomContainerProductsState();
}

class _CustomContainerProductsState extends State<ProductsBody> {
  late ProductsCubit cubit;
  @override
  void initState() {
    super.initState();
    cubit = ProductsCubit();
    cubit.getData();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductsCubit, ProductsState>(
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
          return Center(
            child: SpinKitChasingDots(color: AppColor.kPrimaryColor),
          );
        } else if (state is ProductsLoaded) {
          return ListView.builder(
            itemCount: state.products.length,
            itemBuilder: (context, i) {
              return InkWell(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    ProductDetails.id,
                    arguments: state.products[i],
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
                          offset: Offset(0, 2),
                          blurRadius: 3)
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
                        child: Image.asset(AppImages.klogo),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Text(
                                state.products[i].name ?? "",
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                            ),
                            Text(
                              "${state.products[i].price} ₺",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.favorite_border_outlined),
                          ),
                          IconButton(
                            onPressed: () {
                              final request = AddToCartRequest(
                                  shoppingCartId:
                                      UserSession.shoppingCartId ?? "",
                                  productId: state.products[i].id ?? "",
                                  quantity: 1,
                                  shopId: state.products[i].shopeId!);
                              print(state.products[i].shopeId);

                              cubit.addToCart(request);
                            },
                            icon: const Icon(Icons.shopping_cart),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        } else if (state is ProductsError) {
          return Center(
            child: Text(
              "Error: ${state.error}",
              style: TextStyle(color: Colors.red),
            ),
          );
        } else {
          return const Center(child: Text("Unexpected state"));
        }
      },
    );
  }
}
