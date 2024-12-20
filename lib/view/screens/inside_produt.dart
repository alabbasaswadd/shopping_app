import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/core/constants/colors.dart';
import 'package:shopping_app/core/constants/images.dart';
import 'package:shopping_app/view/widget/products/custom_body_inside_product.dart';

class InsideProdut extends StatelessWidget {
  InsideProdut({super.key});
  static String id = "inside_product";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 4,
        shadowColor: AppColor.kThirtColorDarkMode,
        centerTitle: true,
        title: Text("Product"),
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        child: CustomBodyInsideProduct(),
      ),
    );
  }
}
