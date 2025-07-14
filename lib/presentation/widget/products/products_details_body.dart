import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/core/constants/cached/cached_image.dart';
import 'package:shopping_app/core/widgets/my_text.dart';
import 'package:shopping_app/data/model/products/product_data_model.dart';

class ProductsDetailsBody extends StatelessWidget {
  const ProductsDetailsBody({super.key, required this.product});
  final ProductDataModel product;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          CarouselSlider(
            items: [
              CachedImageWidget(
                imageUrl: product.image ?? "",
                heightRatio: 100,
                widthRatio: 100,
              )
            ],
            options: CarouselOptions(
              autoPlayInterval: const Duration(seconds: 2),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CairoText(product.name ?? ""),
                        CairoText(
                          "${product.price}\$",
                          fontSize: 24,
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    CairoText(
                      product.description ?? "",
                      maxLines: 100,
                      color: Colors.black54,
                    ),
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
