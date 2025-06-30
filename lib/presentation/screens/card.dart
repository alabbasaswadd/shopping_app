import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_app/core/constants/colors.dart';
import 'package:shopping_app/core/widgets/my_app_bar.dart';
import 'package:shopping_app/core/widgets/my_button.dart';
import 'package:shopping_app/data/model/products_model.dart';
import 'package:shopping_app/presentation/screens/payment.dart';
import 'package:shopping_app/presentation/widget/products/products_body.dart';

class CardPage extends StatefulWidget {
  const CardPage({super.key});
  static String id = "cart";

  @override
  State<CardPage> createState() => _CartPageState();
}

class _CartPageState extends State<CardPage> {
  double _totalPrice = 0.0;

  @override
  void initState() {
    super.initState();
    // _calculateTotalPrice();
  }

  // void _calculateTotalPrice() {
  //   setState(() {
  //     _totalPrice = ProductsBody.productsCard.fold(
  //       0.0,
  //       (sum, item) => sum + (item.price * item.quantity),
  //     );
  //   });
  // }

  // void _increaseQuantity(int index) {
  //   setState(() {
  //     ProductsBody.productsCard[index].quantity++;
  //     _calculateTotalPrice();
  //   });
  // }

  // void _decreaseQuantity(int index) {
  //   setState(() {
  //     if (ProductsBody.productsCard[index].quantity > 1) {
  //       ProductsBody.productsCard[index].quantity--;
  //       _calculateTotalPrice();
  //     }
  //   });
  // }

  // void _removeItem(int index) {
  //   setState(() {
  //     ProductsBody.productsCard.removeAt(index);
  //     _calculateTotalPrice();
  //     ScaffoldMessenger.of(Get.context!).showSnackBar(
  //       SnackBar(
  //         content: Text("removed_from_cart".tr),
  //         backgroundColor: AppColor.kRedColor,
  //         behavior: SnackBarBehavior.floating,
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(10),
  //         ),
  //       ),
  //     );
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: myAppBar("card".tr, context),
      body: ProductsBody.productsCard.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.shopping_cart_outlined,
                      size: 80, color: Colors.grey.withOpacity(0.5)),
                  SizedBox(height: 20),
                  Text(
                    "no_products_in_card".tr,
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    padding: EdgeInsets.all(16),
                    separatorBuilder: (_, __) => SizedBox(height: 12),
                    itemCount: ProductsBody.productsCard.length,
                    itemBuilder: (context, index) {
                      final item = ProductsBody.productsCard[index];
                      return _buildCartItem(item, index, theme);
                    },
                  ),
                ),
                _buildCheckoutSection(),
              ],
            ),
    );
  }

  Widget _buildCartItem(ProductsModel item, int index, ThemeData theme) {
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
                item.image,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 12),

            // Product Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4),
                  Text(
                    "\$${item.price.toStringAsFixed(2)}",
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: AppColor.kPrimaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            // Quantity Controls
            Column(
              children: [
                IconButton(
                  icon: Icon(Icons.close, size: 20),
                  onPressed: () => print("edited"),
                  // _removeItem(index),
                  color: Colors.red,
                  padding: EdgeInsets.zero,
                  constraints: BoxConstraints(),
                ),
                SizedBox(height: 8),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove, size: 16),
                        onPressed: () => print("edited"),
                        // _decreaseQuantity(index),
                        padding: EdgeInsets.zero,
                        constraints: BoxConstraints(),
                      ),
                      Text(
                        "sss",
                        style: TextStyle(fontSize: 14),
                      ),
                      IconButton(
                        icon: Icon(Icons.add, size: 16),
                        onPressed: () => print("edited"),
                        // _increaseQuantity(index),
                        padding: EdgeInsets.zero,
                        constraints: BoxConstraints(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCheckoutSection() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, -5),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "total".tr,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "\$${_totalPrice.toStringAsFixed(2)}",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColor.kPrimaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          MyButton(
            text: "proceed_to_checkout".tr,
            onPressed: () => Get.toNamed(Payment.id),
          ),
        ],
      ),
    );
  }
}
