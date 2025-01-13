import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shopping_app/core/constants/colors.dart';
import 'package:shopping_app/presentation/widget/products/appbar/custom_title_appbar_products.dart';
import 'package:shopping_app/presentation/widget/products/custom_container_products.dart';

class CardPage extends StatefulWidget {
  CardPage({super.key});
  static String id = "card";

  @override
  State<CardPage> createState() => _CardPageState();
}

class _CardPageState extends State<CardPage> {
  int notification = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Card"),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.secondary,
      ),
      body: CustomContainerProducts.productsCard.isEmpty
          ? Center(child: Text("No Products In The Card"))
          : ListView.builder(
              itemCount: CustomContainerProducts.productsCard.length,
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
                          CustomContainerProducts.productsCard[i].image ??
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
                                CustomContainerProducts.productsCard[i].title,
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                            ),
                            // مساحة بين النصوص
                            Text(
                              "${CustomContainerProducts.productsCard[i].price} ₺",
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
                                msg: "ٌRemoved From Card",
                                backgroundColor: AppColor.kRedColor);
                            setState(() {
                              CustomContainerProducts.productsCard.removeAt(i);
                            });
                          },
                          icon: const Icon(Icons.remove_shopping_cart,
                              color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                );
              }),
    );
  }
}
