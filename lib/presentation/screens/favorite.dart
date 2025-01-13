import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shopping_app/core/constants/colors.dart';
import 'package:shopping_app/presentation/widget/products/appbar/custom_title_appbar_products.dart';
import 'package:shopping_app/presentation/widget/products/custom_container_products.dart';

class Favorite extends StatefulWidget {
  Favorite({super.key});
  static String id = "favorite";

  @override
  State<Favorite> createState() => _CardPageState();
}

class _CardPageState extends State<Favorite> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorite"),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.secondary,
      ),
      body: CustomContainerProducts.productsFavorite.isEmpty
          ? Center(child: Text("No Products In The Favorite"))
          : ListView.builder(
              itemCount: CustomContainerProducts.productsFavorite.length,
              itemBuilder: (context, i) {
                return Container(
                  padding: EdgeInsets.all(5),
                  height: 142,
                  margin: EdgeInsets.symmetric(vertical: 5),
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    crossAxisAlignment:
                        CrossAxisAlignment.start, // يجعل المحتوى يبدأ من الأعلى
                    children: [
                      Container(
                        height: double.infinity,
                        width: 100,
                        child: Image.network(
                          CustomContainerProducts.productsFavorite[i].image ??
                              "https://i.imgur.com/BG8J0Fj.jpg",
                          fit: BoxFit.fill,
                        ),
                      ),

                      const SizedBox(width: 10), // مساحة بين العناصر

                      // العنصر النصي (title + price)
                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.center, // يبدأ النص من اليسار
                          children: [
                            Expanded(
                              child: Text(
                                CustomContainerProducts
                                    .productsFavorite[i].title,
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                            ),
                            // مساحة بين النصوص
                            Text(
                              "${CustomContainerProducts.productsFavorite[i].price} ₺",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(fontSize: 20),
                            ),
                          ],
                        ),
                      ),

                      // العنصر الأخير (trailing)

                      Center(
                        child: IconButton(
                          onPressed: () {
                            Fluttertoast.showToast(
                                msg: "ٌRemoved From Favorite",
                                backgroundColor: AppColor.kRedColor);
                            setState(() {
                              CustomContainerProducts.productsFavorite
                                  .removeAt(i);
                            });
                          },
                          icon: const Icon(Icons.favorite, color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                );
              }),
    );
  }
}
