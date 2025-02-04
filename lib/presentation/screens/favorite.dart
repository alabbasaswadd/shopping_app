import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shopping_app/core/constants/colors.dart';
import 'package:shopping_app/presentation/widget/products/custom_container_products.dart';

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
        title: const Text("Favorite"),
        centerTitle: true,
        elevation: 8,
        shadowColor: Colors.black,
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
                        CrossAxisAlignment.start, 
                    children: [
                      SizedBox(
                        height: double.infinity,
                        width: 100,
                        child: Image.network(
                          CustomContainerProducts.productsFavorite[i].image,
                             
                          fit: BoxFit.fill,
                        ),
                      ),

                      const SizedBox(width: 10),

                 
                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.center, 
                          children: [
                            Expanded(
                              child: Text(
                                CustomContainerProducts
                                    .productsFavorite[i].title,
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                            ),
                          
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
