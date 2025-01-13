import 'package:flutter/material.dart';
import 'package:shopping_app/core/constants/colors.dart';
import 'package:shopping_app/data/model/products_model.dart';
import 'package:shopping_app/presentation/widget/products/custom_body_inside_product.dart';

class ProdutDetails extends StatelessWidget {
  ProdutDetails({super.key});
  static String id = "product_details";

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
