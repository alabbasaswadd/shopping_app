import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shopping_app/core/constants/colors.dart';
import 'package:shopping_app/core/constants/images.dart';
import 'package:shopping_app/data/repository/products_repository.dart';
import 'package:shopping_app/data/model/products_model.dart';

class CustomContainerProducts extends StatefulWidget {
  CustomContainerProducts({super.key});

  @override
  State<CustomContainerProducts> createState() =>
      _CustomContainerProductsState();
}

class _CustomContainerProductsState extends State<CustomContainerProducts> {
  late Future<List<ProductsModel>> productsFuture;
  @override
  void initState() {
    ff();
    super.initState();
  }

  void ff() async {
    productsFuture = ProductsRepository().getData();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
        future: productsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: SpinKitChasingDots(color: AppColor.kPrimaryColor),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            List<dynamic> productsList = snapshot.data!;
            return ListView.builder(
                itemCount: productsList.length,
                itemBuilder: (context, i) {
                  return Container(
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
                              productsList[i].image ??
                                  "https://i.imgur.com/BG8J0Fj.jpg",
                              fit: BoxFit.fill,
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
                                    productsList[i].title,
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  ),
                                ),
                                // مساحة بين النصوص
                                Text(
                                  "${productsList[i].price} ₺",
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
                      ));
                });
          } else {
            return Center(child: Text('No products found.'));
          }
        });
  }
}
