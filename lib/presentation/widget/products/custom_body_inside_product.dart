import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/core/constants/colors.dart';
import 'package:shopping_app/core/constants/images.dart';
import 'package:shopping_app/data/model/products_model.dart';
import 'package:shopping_app/presentation/widget/products/custom_material_button_product.dart';

class CustomBodyInsideProduct extends StatelessWidget {
  CustomBodyInsideProduct({super.key});

  List<Widget> items = [
    Image.asset(AppImages.kHeadPhone),
    Image.asset(AppImages.kHeadPhone),
    Image.asset(AppImages.kHeadPhone),
    Image.asset(AppImages.kHeadPhone),
  ];

  @override
  Widget build(BuildContext context) {
    // استقبال بيانات المنتج المُرسل عبر Navigator
    final ProductsModel productDetails =
        ModalRoute.of(context)!.settings.arguments as ProductsModel;

    return SingleChildScrollView(
      child: Column(
        children: [
          // Carousel Slider
          CarouselSlider(
            items: items,
            options: CarouselOptions(
              autoPlayInterval: const Duration(seconds: 3),
              autoPlay: true,
            ),
          ),
          SizedBox(height: 20),

          // عرض بيانات المنتج حسب الفهرس (index)
          ListView.builder(
            shrinkWrap: true, // لتجنب مشاكل التخطيط
            physics: NeverScrollableScrollPhysics(), // تعطيل التمرير الداخلي
            itemCount: 1,
            itemBuilder: (context, i) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Product Title
                    Text(productDetails.title,
                        style: Theme.of(context).textTheme.bodyLarge),
                    SizedBox(height: 20),

                    // Price and Storage Info
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            productDetails.description ?? "",
                            style: Theme.of(context).textTheme.bodyLarge,
                            overflow: TextOverflow
                                .fade, // يضيف "..." إذا كان النص طويلًا

                            softWrap: true, // يسمح بالتفاف النص
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),

                    // Expiry Date and Barcode
                    Text(productDetails.price.toString()),
                    SizedBox(height: 20),

                    // Product Image
                    // Container(
                    //   width: double.infinity,
                    //   child: Image.asset(
                    //     AdaptiveTheme.of(context).mode ==
                    //             AdaptiveThemeMode.light
                    //         ? AppImages.kBackground
                    //         : AppImages.kBackgroundDark,
                    //     fit: BoxFit.cover,
                    //   ),
                    // ),
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
