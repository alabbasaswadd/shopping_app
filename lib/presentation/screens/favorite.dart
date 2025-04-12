import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shopping_app/core/constants/colors.dart';
import 'package:shopping_app/presentation/widget/products/products_body.dart';

class Favorite extends StatefulWidget {
  const Favorite({super.key});
  static String id = "favorite";

  @override
  State<Favorite> createState() => _CardPageState();
}

class _CardPageState extends State<Favorite> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("favorite".tr),
        centerTitle: true,
        elevation: 8,
        shadowColor: Colors.black,
      ),
      body: ProductsBody.productsFavorite.isEmpty
          ? Center(child: Text("no_products_in_favorite".tr))
          : ListView.builder(
              itemCount: ProductsBody.productsFavorite.length,
              itemBuilder: (context, i) {
                return Container(
                  padding: EdgeInsets.all(5),
                  height: 142,
                  margin: EdgeInsets.symmetric(vertical: 5),
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: double.infinity,
                        width: 100,
                        child: Image.network(
                          ProductsBody.productsFavorite[i].image,
                          fit: BoxFit.fill,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Text(
                                ProductsBody
                                    .productsFavorite[i].title,
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                            ),
                            Text(
                              "${ProductsBody.productsFavorite[i].price} ₺",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                      Center(
                        child: IconButton(
                          onPressed: () {
                            Fluttertoast.showToast(
                                msg: "ٌRemoved From Favorite",
                                backgroundColor: AppColor.kRedColor);
                            setState(() {
                              ProductsBody.productsFavorite
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
