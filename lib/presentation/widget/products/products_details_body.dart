import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/core/constants/images.dart';
import 'package:shopping_app/data/model/products/product_data_model.dart';

class ProductsDetailsBody extends StatelessWidget {
  const ProductsDetailsBody({super.key});
  @override
  Widget build(BuildContext context) {
    final ProductDataModel productDetails =
        ModalRoute.of(context)!.settings.arguments as ProductDataModel;

    return SingleChildScrollView(
      child: Column(
        children: [
          CarouselSlider(
            items: [
              // Image.network(productDetails.image),
              // Image.network(productDetails.image),
              Image.asset(AppImages.kCamera)
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
                    Text(productDetails.name ?? "",
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
