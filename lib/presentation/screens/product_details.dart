import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shopping_app/core/constants/colors.dart';
import 'package:shopping_app/core/widgets/my_app_bar.dart';
import 'package:shopping_app/data/model/products_model.dart';
import 'package:shopping_app/presentation/widget/products/products_details_body.dart';
import '../widget/products/products_body.dart';

class ProductDetails extends StatelessWidget {
  const ProductDetails({super.key});
  static String id = "product_details";

  @override
  Widget build(BuildContext context) {
    final ProductsModel productDetails =
        ModalRoute.of(context)!.settings.arguments as ProductsModel;
    return Scaffold(
      appBar: myAppBar("product_details".tr, context),
      body: Container(
        padding: EdgeInsets.all(15),
        child: const ProductsDetailsBody(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          bool isAlreadyAdded = ProductsBody.productsCard.any(
            (product) => product.name == productDetails.name,
          );

          if (isAlreadyAdded) {
            Fluttertoast.showToast(
              msg: "Already in the Favorite",
              backgroundColor: AppColor.kRedColor,
            );
          } else {
            ProductsBody.productsCard.add(ProductsModel(
                name: productDetails.name,
                image: productDetails.image,
                price: productDetails.price,
                categoryId: '',
                currency: '',
                shopeId: '',
                description: ''));
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
