import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shopping_app/presentation/business_logic/cubit/products/products_cubit.dart';
import 'package:shopping_app/presentation/business_logic/cubit/searching/searching_cubit.dart';
import 'package:shopping_app/core/constants/colors.dart';
import 'package:shopping_app/data/model/products_model.dart';
import 'package:shopping_app/presentation/screens/product_details.dart';

class ProductsBody extends StatefulWidget {
  const ProductsBody({super.key});
  static List<ProductsModel> productsInside = [];
  static List<ProductsModel> productsCard = [];
  static List<ProductsModel> productsFavorite = [];

  @override
  State<ProductsBody> createState() => _CustomContainerProductsState();
}

class _CustomContainerProductsState extends State<ProductsBody> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ProductsCubit>(context).getData();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsCubit, ProductsState>(
      builder: (context, state) {
        if (state is ProductsLoading) {
          return Center(
            child: SpinKitChasingDots(color: AppColor.kPrimaryColor),
          );
        } else if (state is ProductsSuccess) {
          context.read<SearchingCubit>().setAllProducts(state.products);
          return BlocBuilder<SearchingCubit, SearchingState>(
            builder: (context, searchState) {
              List<ProductsModel> displayedProducts = searchState is IsSearching
                  ? searchState.productsSearching
                  : state.products;

              if (displayedProducts.isEmpty) {
                return const Center(
                  child: Text("No Products Found"),
                );
              }
              return ListView.builder(
                itemCount: displayedProducts.length,
                itemBuilder: (context, i) {
                  return InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        ProductDetails.id,
                        arguments: displayedProducts[i],
                      );
                      ProductsBody.productsInside.clear();
                      ProductsBody.productsInside.add(
                        displayedProducts[i],
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
                            child: Image.network(
                              displayedProducts[i].image,
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Image.asset(
                                  'assets/images/loading.gif',
                                  fit: BoxFit.cover,
                                );
                              },
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Text(
                                    displayedProducts[i].name,
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  ),
                                ),
                                Text(
                                  "${displayedProducts[i].price} ₺",
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
                                onPressed: () {
                                  bool isAlreadyAdded = ProductsBody
                                      .productsFavorite
                                      .any((product) =>
                                          product.name ==
                                          displayedProducts[i].name);

                                  if (isAlreadyAdded) {
                                    Fluttertoast.showToast(
                                      msg: "Already in the Favorite",
                                      backgroundColor: AppColor.kRedColor,
                                    );
                                  } else {
                                    Fluttertoast.showToast(
                                      msg: "Added To Favorite",
                                      backgroundColor: AppColor.kPrimaryColor,
                                    );

                                    ProductsBody.productsFavorite
                                        .add(displayedProducts[i]);
                                  }
                                },
                                icon:
                                    const Icon(Icons.favorite_border_outlined),
                              ),
                              IconButton(
                                onPressed: () {
                                  bool isAlreadyAdded =
                                      ProductsBody.productsCard.any(
                                    (product) =>
                                        product.name ==
                                        displayedProducts[i].name,
                                  );

                                  if (isAlreadyAdded) {
                                    Fluttertoast.showToast(
                                      msg: "Already in the Cart",
                                      backgroundColor: AppColor.kRedColor,
                                    );
                                  } else {
                                    Fluttertoast.showToast(
                                      msg: "Added To Cart",
                                      backgroundColor: AppColor.kPrimaryColor,
                                    );

                                    ProductsBody.productsCard
                                        .add(displayedProducts[i]);
                                  }
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
