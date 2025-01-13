import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shopping_app/business_logic/cubit/products/products_cubit.dart';
import 'package:shopping_app/core/constants/colors.dart';
import 'package:shopping_app/data/repository/products_repository.dart';
import 'package:shopping_app/data/model/products_model.dart';
import 'package:shopping_app/data/web_services/products_web_services.dart';
import 'package:shopping_app/presentation/screens/produc_details.dart';

class CustomContainerProducts extends StatefulWidget {
  CustomContainerProducts({super.key});
  static List<ProductsModel> productsInside = [];
  static List<ProductsModel> productsCard = [];

  static List<ProductsModel> productsFavorite = [];
  @override
  State<CustomContainerProducts> createState() =>
      _CustomContainerProductsState();
}

class _CustomContainerProductsState extends State<CustomContainerProducts> {
  late Future<List<ProductsModel>> productsFuture;
  late List<ProductsModel> products;
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ProductsCubit>(context).getData();
  }

  void ff() {
    productsFuture = ProductsRepository(ProductsWebServices()).getData();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsCubit, ProductsState>(builder: (context, state) {
      if (state is ProductsLoading) {
        return Center(
          child: SpinKitChasingDots(color: AppColor.kPrimaryColor),
        );
      } else if (state is ProductsSuccess) {
        products = (state).products;
        return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, i) {
              return InkWell(
                onTap: () {
                  // تمرير المنتج المحدد فقط إلى صفحة التفاصيل
                  Navigator.pushNamed(context, ProdutDetails.id,
                      arguments: products[i] // تمرير المنتج المحدد فقط
                      );

                  // تخزين المنتج المحدد فقط في قائمة productsInside
                  CustomContainerProducts.productsInside
                      .clear(); // تفريغ القائمة لتجنب التكرار
                  CustomContainerProducts.productsInside.add(ProductsModel(
                    title: products[i].title,
                    description: products[i].description,
                    image: products[i].image,
                    price: products[i].price,
                  ));
                },
                child: Container(
                    padding: EdgeInsets.all(5),
                    height: 142,
                    margin: EdgeInsets.symmetric(vertical: 5),
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondary,
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment
                          .start, // يجعل المحتوى يبدأ من الأعلى
                      children: [
                        Container(
                          height: double.infinity,
                          width: 100,
                          child: Image.network(
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) {
                                // عرض الصورة الأصلية عند اكتمال التحميل
                                return child;
                              }

                              return Image.asset(
                                'assets/images/loading.gif', // الصورة المؤقتة من ملفات الأصول
                                fit: BoxFit.cover,
                              );
                            },
                            products[i].image,
                          ),
                        ),

                        const SizedBox(width: 10), // مساحة بين العناصر

                        // العنصر النصي (title + price)
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment
                                .center, // يبدأ النص من اليسار
                            children: [
                              Expanded(
                                child: Text(
                                  products[i].title,
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                              ),
                              // مساحة بين النصوص
                              Text(
                                "${products[i].price} ₺",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(fontSize: 20),
                              ),
                            ],
                          ),
                        ),

                        // العنصر الأخير (trailing)
                        Column(
                          children: [
                            IconButton(
                              onPressed: () {
                                CustomContainerProducts.productsFavorite.add(
                                    ProductsModel(
                                        title: products[i].title,
                                        description: products[i].description,
                                        image: products[i].image,
                                        price: products[i].price));
                                Fluttertoast.showToast(
                                    msg: "Added To Favorite",
                                    backgroundColor: AppColor.kPrimaryColor);
                              },
                              icon: const Icon(Icons.favorite_border_outlined),
                            ),
                            IconButton(
                              onPressed: () {
                                Fluttertoast.showToast(
                                    msg: "Added To Card",
                                    backgroundColor: AppColor.kPrimaryColor);
                                CustomContainerProducts.productsCard.add(
                                    ProductsModel(
                                        title: products[i].title,
                                        description: products[i].description,
                                        image: products[i].image,
                                        price: products[i].price));
                              },
                              icon: const Icon(Icons.shopping_cart),
                            ),
                          ],
                        ),
                      ],
                    )),
              );
            });
      } else {
        return Text("Error");
      }
    });
  }
}
