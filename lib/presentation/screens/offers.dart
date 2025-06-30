import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_app/core/constants/colors.dart';
import 'package:shopping_app/core/constants/images.dart';
import 'package:shopping_app/core/widgets/my_app_bar.dart';
import 'package:shopping_app/core/widgets/my_card.dart';
import 'package:shopping_app/presentation/widget/products/products_body.dart';

class Offers extends StatelessWidget {
  const Offers({super.key});
  static String id = "offers";

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: myAppBar("offers".tr, context),
      body: ProductsBody.productsCard.isEmpty
          ? _buildEmptyState(theme)
          : _buildOffersList(),
    );
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

  Widget _buildOffersList() {
    return ListView.separated(
      padding: EdgeInsets.all(16),
      separatorBuilder: (_, __) => SizedBox(height: 16),
      itemCount: ProductsBody.productsCard.length,
      itemBuilder: (context, index) => _buildOfferItem(index, context),
    );
  }

  Widget _buildOfferItem(int index, BuildContext context) {
    final product = ProductsBody.productsCard[index];

    return MyCard(
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {},
          child: Padding(
            padding: EdgeInsets.all(12),
            child: Row(
              children: [
                // Product Image with Discount Badge
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        product.image,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      top: 8,
                      left: 8,
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          "20% OFF", // يمكن استبدالها بقيمة الخصم الفعلية
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 12),

                // Product Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 8),

                      // Price with discount
                      Row(
                        children: [
                          Text(
                            "${product.price} ₺",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppColor.kPrimaryColor,
                            ),
                          ),
                          SizedBox(width: 8),
                          Text(
                            "${product.price * 1.25} ₺", // السعر قبل الخصم
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        ],
                      ),

                      // Rating and Time Left
                      SizedBox(height: 8),
                      Row(
                        children: const [
                          Icon(Icons.star, color: Colors.amber, size: 16),
                          SizedBox(width: 4),
                          Text("4.8"),
                          Spacer(),
                          Text(
                            "24h left", // الوقت المتبقي للعرض
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
