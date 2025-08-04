import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_app/core/constants/images.dart';
import 'package:shopping_app/core/widgets/my_app_bar.dart';
import 'package:shopping_app/core/widgets/my_text.dart';

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
        appBar: myAppBar(title: "favorite".tr, context: context),
        body: _buildEmptyFavoriteState(theme));
  }

  Widget _buildEmptyFavoriteState(ThemeData theme) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(AppImages.klogo, width: 200, height: 200),
          SizedBox(height: 20),
          CairoText(
            "no_products_in_favorite".tr,
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
