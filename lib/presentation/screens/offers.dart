import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_app/core/constants/images.dart';
import 'package:shopping_app/core/widgets/my_app_bar.dart';

class Offers extends StatelessWidget {
  const Offers({super.key});
  static String id = "offers";

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
        appBar: myAppBar(title: "offers".tr, context: context),
        body: _buildEmptyState(theme));
  }

  Widget _buildEmptyState(ThemeData theme) {
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
            "no_offers_available".tr,
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}
