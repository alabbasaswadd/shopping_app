// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:shopping_app/business_logic/cubit/products/products_cubit.dart';
// import 'package:shopping_app/core/constants/colors.dart';
// import 'package:shopping_app/data/repository/products_repository.dart';
// import 'package:shopping_app/data/model/products_model.dart';
// import 'package:shopping_app/data/web_services/products_web_services.dart';
// import 'package:shopping_app/presentation/screens/produc_details.dart';
// import 'appbar/custom_title_appbar_products.dart';

// class CustomContainerProducts extends StatefulWidget {
//   const CustomContainerProducts({super.key});
//   static List<ProductsModel> productsInside = [];
//   static List<ProductsModel> productsCard = [];
//   static List<ProductsModel> productsFavorite = [];

//   @override
//   State<CustomContainerProducts> createState() =>
//       _CustomContainerProductsState();
// }

// class _CustomContainerProductsState extends State<CustomContainerProducts> {
//   late Future<List<ProductsModel>> productsFuture;
//   late List<ProductsModel> products;
//   @override
//   void initState() {
//     super.initState();
//     BlocProvider.of<ProductsCubit>(context).getData();
//   }

//   void ff() {
//     productsFuture = ProductsRepository(ProductsWebServices()).getData();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<ProductsCubit, ProductsState>(builder: (context, state) {
//       if (state is ProductsLoading) {
//         return Center(
//           child: SpinKitChasingDots(color: AppColor.kPrimaryColor),
//         );
//       } else if (state is ProductsSuccess) {
//         products = (state).products;
//         return ListView.builder(
//             itemCount: CustomTitleAppbarProducts.controller.text == ""
//                 ? products.length
//                 : CustomTitleAppbarProducts.productsSearch.length,
//             itemBuilder: (context, i) {
//               return InkWell(
//                 onTap: () {
//                   Navigator.pushNamed(context, ProdutDetails.id,
//                       arguments: products[i]);

//                   CustomContainerProducts.productsInside.clear();
//                   CustomContainerProducts.productsInside.add(ProductsModel(
//                     title: products[i].title,
//                     description: products[i].description,
//                     image: products[i].image,
//                     price: products[i].price,
//                   ));
//                 },
//                 child: Container(
//                     padding: EdgeInsets.all(5),
//                     height: 142,
//                     margin: EdgeInsets.symmetric(vertical: 5),
//                     decoration: BoxDecoration(
//                         color: Theme.of(context).colorScheme.secondary,
//                         borderRadius: BorderRadius.circular(10)),
//                     child: Row(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         SizedBox(
//                           height: double.infinity,
//                           width: 100,
//                           child: Image.network(
//                             loadingBuilder: (context, child, loadingProgress) {
//                               if (loadingProgress == null) {
//                                 return child;
//                               }

//                               return Image.asset(
//                                 'assets/images/loading.gif',
//                                 fit: BoxFit.cover,
//                               );
//                             },
//                             CustomTitleAppbarProducts.controller.text == ""
//                                 ? products[i].image
//                                 : CustomTitleAppbarProducts
//                                     .productsSearch[i].image,
//                           ),
//                         ),
//                         const SizedBox(width: 10),
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               Expanded(
//                                 child: Text(
//                                   CustomTitleAppbarProducts.controller.text ==
//                                           ""
//                                       ? products[i].title
//                                       : CustomTitleAppbarProducts
//                                           .productsSearch[i].title,
//                                   style: Theme.of(context).textTheme.bodyLarge,
//                                 ),
//                               ),
//                               Text(
//                                 "${CustomTitleAppbarProducts.controller.text == "" ? products[i].price : CustomTitleAppbarProducts.productsSearch[i].price} ₺",
//                                 style: Theme.of(context)
//                                     .textTheme
//                                     .titleLarge!
//                                     .copyWith(fontSize: 20),
//                               ),
//                             ],
//                           ),
//                         ),
//                         Column(
//                           children: [
//                             IconButton(
//                               onPressed: () {
//                                 bool isAlreadyAdded = CustomContainerProducts
//                                     .productsFavorite
//                                     .any(
//                                   (product) =>
//                                       product.title == products[i].title,
//                                 );

//                                 if (isAlreadyAdded) {
//                                   Fluttertoast.showToast(
//                                     msg: "Already in the Favorite",
//                                     backgroundColor: AppColor.kRedColor,
//                                   );
//                                 } else {
//                                   Fluttertoast.showToast(
//                                     msg: "Added To Favorite",
//                                     backgroundColor: AppColor.kPrimaryColor,
//                                   );

//                                   CustomContainerProducts.productsFavorite.add(
//                                     ProductsModel(
//                                       title: products[i].title,
//                                       description: products[i].description,
//                                       image: products[i].image,
//                                       price: products[i].price,
//                                       quantity: 1,
//                                     ),
//                                   );
//                                 }
//                               },
//                               icon: const Icon(Icons.favorite_border_outlined),
//                             ),
//                             IconButton(
//                               onPressed: () {
//                                 bool isAlreadyAdded =
//                                     CustomContainerProducts.productsCard.any(
//                                   (product) =>
//                                       product.title == products[i].title,
//                                 );

//                                 if (isAlreadyAdded) {
//                                   Fluttertoast.showToast(
//                                     msg: "Already in the Cart",
//                                     backgroundColor: AppColor.kRedColor,
//                                   );
//                                 } else {
//                                   Fluttertoast.showToast(
//                                     msg: "Added To Cart",
//                                     backgroundColor: AppColor.kPrimaryColor,
//                                   );

//                                   CustomContainerProducts.productsCard.add(
//                                     ProductsModel(
//                                       title: products[i].title,
//                                       description: products[i].description,
//                                       image: products[i].image,
//                                       price: products[i].price,
//                                       quantity: 1,
//                                     ),
//                                   );
//                                 }
//                               },
//                               icon: const Icon(Icons.shopping_cart),
//                             ),
//                           ],
//                         ),
//                       ],
//                     )),
//               );
//             });
//       } else {
//         return Text("Error");
//       }
//     });
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shopping_app/business_logic/cubit/products/products_cubit.dart';
import 'package:shopping_app/business_logic/cubit/searching/cubit/searching_cubit.dart';
import 'package:shopping_app/core/constants/colors.dart';
import 'package:shopping_app/data/model/products_model.dart';
import 'package:shopping_app/presentation/screens/produc_details.dart';

class CustomContainerProducts extends StatefulWidget {
  const CustomContainerProducts({super.key});
  static List<ProductsModel> productsInside = [];
  static List<ProductsModel> productsCard = [];
  static List<ProductsModel> productsFavorite = [];

  @override
  State<CustomContainerProducts> createState() =>
      _CustomContainerProductsState();
}

class _CustomContainerProductsState extends State<CustomContainerProducts> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ProductsCubit>(context).getData();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProductsCubit, ProductsState>(
      listener: (context, state) {
        if (state is ProductsSuccess) {
          BlocProvider.of<SearchingCubit>(context).setProducts(state.products);
        }
      },
      child: BlocBuilder<SearchingCubit, SearchingState>(
        builder: (context, state) {
          List<ProductsModel> displayedProducts = [];

          if (state is NotSearching) {
            displayedProducts = state.products;
          } else if (state is IsSearching) {
            displayedProducts = state.productsSearching;
          }

          return displayedProducts.isEmpty
              ? Center(child: Text("No Products Search"))
              : ListView.builder(
                  itemCount: displayedProducts.length,
                  itemBuilder: (context, i) {
                    return InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, ProdutDetails.id,
                            arguments: displayedProducts[i]);

                        CustomContainerProducts.productsInside.clear();
                        CustomContainerProducts.productsInside.add(
                          ProductsModel(
                            title: displayedProducts[i].title,
                            description: displayedProducts[i].description,
                            image: displayedProducts[i].image,
                            price: displayedProducts[i].price,
                          ),
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.all(5),
                        height: 142,
                        margin: EdgeInsets.symmetric(vertical: 5),
                        decoration: BoxDecoration(
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
                                      displayedProducts[i].title,
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
                                    bool isAlreadyAdded =
                                        CustomContainerProducts.productsFavorite
                                            .any(
                                      (product) =>
                                          product.title ==
                                          displayedProducts[i].title,
                                    );

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

                                      CustomContainerProducts.productsFavorite
                                          .add(
                                        ProductsModel(
                                          title: displayedProducts[i].title,
                                          description:
                                              displayedProducts[i].description,
                                          image: displayedProducts[i].image,
                                          price: displayedProducts[i].price,
                                          quantity: 1,
                                        ),
                                      );
                                    }
                                  },
                                  icon: const Icon(
                                      Icons.favorite_border_outlined),
                                ),
                                IconButton(
                                  onPressed: () {
                                    bool isAlreadyAdded =
                                        CustomContainerProducts.productsCard
                                            .any(
                                      (product) =>
                                          product.title ==
                                          displayedProducts[i].title,
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

                                      CustomContainerProducts.productsCard.add(
                                        ProductsModel(
                                          title: displayedProducts[i].title,
                                          description:
                                              displayedProducts[i].description,
                                          image: displayedProducts[i].image,
                                          price: displayedProducts[i].price,
                                          quantity: 1,
                                        ),
                                      );
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
      ),
    );
  }
}
