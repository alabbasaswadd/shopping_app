import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shopping_app/core/constants/colors.dart';
import 'package:shopping_app/data/model/products_model.dart';
import 'package:shopping_app/presentation/widget/products/custom_body_inside_product.dart';
import '../widget/products/custom_container_products.dart';

class ProdutDetails extends StatelessWidget {
  const ProdutDetails({super.key});
  static String id = "product_details";

  @override
  Widget build(BuildContext context) {
    final ProductsModel productDetails =
        ModalRoute.of(context)!.settings.arguments as ProductsModel;
    return Scaffold(
      appBar: AppBar(
        elevation: 8,
        shadowColor: Colors.black,
        centerTitle: true,
        title: Text("Product"),
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        child: const CustomBodyInsideProduct(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          bool isAlreadyAdded = CustomContainerProducts.productsCard.any(
            (product) => product.title == productDetails.title,
          );

          if (isAlreadyAdded) {
            Fluttertoast.showToast(
              msg: "Already in the Favorite",
              backgroundColor: AppColor.kRedColor,
            );
          } else {
            CustomContainerProducts.productsCard.add(ProductsModel(
                title: productDetails.title,
                image: productDetails.image,
                price: productDetails.price));
            Fluttertoast.showToast(
              msg: "Added To Favorite",
              backgroundColor: AppColor.kPrimaryColor,
            );
          }
        },
        child: Icon(
          Icons.shopping_cart,
          color: AppColor.kWhiteColor,
        ),
      ),
    );
  }
}
