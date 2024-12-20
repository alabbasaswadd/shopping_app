import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/core/constants/colors.dart';
import 'package:shopping_app/core/constants/images.dart';
import 'package:shopping_app/view/widget/products/custom_container_products.dart';
import 'package:shopping_app/view/widget/products/custom_material_button_product.dart';

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
    return ListView(
      children: [
        CarouselSlider(items: items, options: CarouselOptions(autoPlay: true)),
        Text(CustomContainerProducts.productsInside[0].title),
        SizedBox(height: 20),
        Row(
          children: [
            Text("300 TMT"),
            Spacer(),
            Container(
              decoration: BoxDecoration(
                  color: AppColor.kSecondColor,
                  borderRadius: BorderRadius.circular(50)),
              child: Text("In Storage 450"),
            )
          ],
        ),
        SizedBox(height: 20),
        const Row(
          children: [
            Text("EXP date: 23.05.2025"),
            Spacer(),
            Text("4006581016825")
          ],
        ),
        SizedBox(height: 20),
        Text(
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi non erat quam. Vestibulum aliquam nibh dui, et aliquet nibh euismod quis."),
        SizedBox(height: 20),
        Container(
          child: Image.asset(
              AdaptiveTheme.of(context).mode == AdaptiveThemeMode.light
                  ? AppImages.kBackground
                  : AppImages.kBackgroundDark),
        ),
        Row(
          children: [
            Row(
              children: [
                CustomMaterialButtonProduct(
                  text: "-",
                  color: Theme.of(context).colorScheme.secondary,
                  colorText: AppColor.kPrimaryColor,
                ),
                Text("1028"),
                CustomMaterialButtonProduct(
                  text: "+",
                  color: AppColor.kPrimaryColor,
                  colorText: AppColor.kWhiteColor,
                ),
              ],
            ),
            Spacer(),
            Container(
              child: MaterialButton(
                color: AppColor.kPrimaryColor,
                textColor: AppColor.kWhiteColor,
                onPressed: () {},
                child: Text("Add To Card"),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
