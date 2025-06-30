import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_app/core/constants/colors.dart';
import 'package:shopping_app/core/widgets/my_app_bar.dart';
import 'package:shopping_app/core/widgets/my_button.dart';

class Payment extends StatelessWidget {
  const Payment({super.key});
  static String id = "payment";

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: myAppBar("payment".tr,context),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Order Summary
            _buildSectionHeader("order_summary".tr),
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _buildOrderRow("subtotal".tr, "\$125.00"),
                    _buildOrderRow("shipping".tr, "\$5.99"),
                    _buildOrderRow("tax".tr, "\$10.25"),
                    const Divider(height: 24),
                    _buildOrderRow(
                      "total".tr,
                      "\$141.24",
                      isTotal: true,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Payment Methods
            _buildSectionHeader("payment_method".tr),
            _buildPaymentMethod(
              icon: Icons.credit_card,
              title: "credit_card".tr,
              isSelected: true,
            ),
            _buildPaymentMethod(
              icon: Icons.paypal,
              title: "PayPal",
              isSelected: false,
            ),
            _buildPaymentMethod(
              icon: Icons.apple,
              title: "Apple Pay",
              isSelected: false,
            ),
            const SizedBox(height: 24),

            // Card Details (visible when credit card selected)
            _buildSectionHeader("card_details".tr),
            _buildCardForm(),

            // Shipping Address
            const SizedBox(height: 24),
            _buildSectionHeader("shipping_address".tr),
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "John Doe",
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text("123 Main Street"),
                    Text("New York, NY 10001"),
                    Text("United States"),
                    const SizedBox(height: 8),
                    Text(
                      "+1 (234) 567-8900",
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          // Edit address
                        },
                        child: Text(
                          "edit".tr,
                          style: TextStyle(color: AppColor.kPrimaryColor),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: MyButton(
            text: "pay_now".tr + " \$141.24",
            onPressed: () {
              // Process payment
              _showPaymentSuccessDialog(context);
            },
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.grey[700],
        ),
      ),
    );
  }

  Widget _buildOrderRow(String label, String value, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.grey[600],
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              fontSize: isTotal ? 16 : 14,
              color: isTotal ? AppColor.kPrimaryColor : Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentMethod({
    required IconData icon,
    required String title,
    required bool isSelected,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(
          color: isSelected ? AppColor.kPrimaryColor : Colors.grey.shade300,
          width: isSelected ? 1.5 : 1,
        ),
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: isSelected ? AppColor.kPrimaryColor : Colors.grey[600],
        ),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        trailing: isSelected
            ? Icon(
                Icons.check_circle,
                color: AppColor.kPrimaryColor,
              )
            : null,
        onTap: () {
          // Change payment method
        },
      ),
    );
  }

  Widget _buildCardForm() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(
                labelText: "card_number".tr,
                hintText: "1234 5678 9012 3456",
                suffixIcon: Icon(Icons.credit_card),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: "expiry_date".tr,
                      hintText: "MM/YY",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: "CVV".tr,
                      hintText: "123",
                      suffixIcon: Icon(Icons.help_outline),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: InputDecoration(
                labelText: "cardholder_name".tr,
                hintText: "John Doe",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showPaymentSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: Icon(
          Icons.check_circle,
          color: Colors.green,
          size: 60,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "payment_successful".tr,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              "thank_you_for_your_purchase".tr,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey[600]),
            ),
          ],
        ),
        actions: [
          Center(
            child: MyButton(
              text: "continue_shopping".tr,
              onPressed: () {
                Navigator.popUntil(context, (route) => route.isFirst);
              },
            ),
          ),
        ],
      ),
    );
  }
}
