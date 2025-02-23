import 'package:flutter/material.dart';
import 'package:shopping_app/presentation/widget/products/custom_container_products.dart';
class Offers extends StatelessWidget {
  const Offers({super.key});
  static String id = "offers";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Offers"),
        centerTitle: true,
        elevation: 8,
        shadowColor: Colors.black,
      ),
      body: CustomContainerProducts.productsCard.isEmpty
          ? Center(child: Text("No Products In Offers"))
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: double.infinity,
                          width: 100,
                          child: Image.network(
                            CustomContainerProducts.productsCard[i].image,
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
                                  CustomContainerProducts.productsCard[i].title,
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                              ),
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
                      ]),
                );
              },
            ),
    );
  }
}
