import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_app/core/constants/colors.dart';
import 'package:shopping_app/core/constants/images.dart';
import 'package:shopping_app/core/widgets/my_app_bar.dart';
import 'package:shopping_app/core/widgets/my_snackbar.dart';
import 'package:shopping_app/presentation/widget/products/products_body.dart';

class Favorite extends StatefulWidget {
  const Favorite({super.key});
  static String id = "favorite";

  @override
  State<Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: myAppBar("favorite".tr, context),
      body: ProductsBody.productsFavorite.isEmpty
          ? _buildEmptyFavoriteState(theme)
          : _buildFavoriteList(),
    );
  }

  Widget _buildEmptyFavoriteState(ThemeData theme) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            AppImages.klogo,
            width: 200,
            height: 200,
          ),
          SizedBox(height: 20),
          Text(
            "no_products_in_favorite".tr,
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _buildFavoriteList() {
    return ListView.separated(
      padding: EdgeInsets.all(16),
      separatorBuilder: (_, __) => SizedBox(height: 16),
      itemCount: ProductsBody.productsFavorite.length,
      itemBuilder: (context, index) => _buildFavoriteItem(index),
    );
  }

  Widget _buildFavoriteItem(int index) {
    final product = ProductsBody.productsFavorite[index];

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Row(
          children: [
            // Product Image
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                product.image ?? "",
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 16),

            // Product Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name ?? "",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 8),
                  Text(
                    "${product.price} ₺",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColor.kPrimaryColor,
                    ),
                  ),
                ],
              ),
            ),

            // Favorite Button
            IconButton(
              icon: Icon(Icons.favorite, color: Colors.red),
              onPressed: () => _removeFromFavorite(index),
            ),
          ],
        ),
      ),
    );
  }

  void _removeFromFavorite(int index) {
    setState(() {
      ProductsBody.productsFavorite.removeAt(index);
    });
    // MySnackbar.show(
    //   title: "removed".tr,
    //   message: "removed_from_favorite".tr,
    //   backgroundColor: AppColor.kRedColor,
    // );
  }
}
