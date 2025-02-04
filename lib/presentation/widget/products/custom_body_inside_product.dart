import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/data/model/products_model.dart';

class CustomBodyInsideProduct extends StatelessWidget {
  const CustomBodyInsideProduct({super.key});
  @override
  Widget build(BuildContext context) {
    final ProductsModel productDetails =
        ModalRoute.of(context)!.settings.arguments as ProductsModel;

    return SingleChildScrollView(
      child: Column(
        children: [
          CarouselSlider(
            items: [
              Image.network(productDetails.image),
              Image.network(productDetails.image),
            ],
            options: CarouselOptions(
              autoPlayInterval: const Duration(seconds: 3),
              autoPlay: true,
            ),
          ),
          SizedBox(height: 20),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: 1,
            itemBuilder: (context, i) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(productDetails.title,
                        style: Theme.of(context).textTheme.bodyLarge),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            productDetails.description ?? "",
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(color: Colors.grey[600]),
                            overflow: TextOverflow.fade,
                            softWrap: true,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Text(
                      "${productDetails.price} ₺",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
