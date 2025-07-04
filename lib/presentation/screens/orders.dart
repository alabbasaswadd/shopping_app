import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:shopping_app/core/constants/colors.dart';
import 'package:shopping_app/core/widgets/my_app_bar.dart';

class Orders extends StatelessWidget {
  Orders({super.key});
  static String id = "orders";

  final List<OrderModel> orders = [
    OrderModel(
      address: "Ashgabat, 1 Mkr, Ul. Swaboda, Dom №16A (Beki), 271496",
      description: "iPhone 13 Pro Max (256GB) - Sierra Blue",
      date: "18/5/2021",
      status: OrderStatus.delivered,
      items: [
        OrderItem("iPhone 13 Pro Max", 1, 1099.99),
        OrderItem("Apple Care+", 1, 199.99),
      ],
    ),
    OrderModel(
      address: "New York, 45th Street, Apartment 12",
      description: "Gaming Laptop Bundle",
      date: "22/7/2023",
      status: OrderStatus.pending,
      items: [
        OrderItem("ASUS ROG Zephyrus", 1, 2499.99),
        OrderItem("Gaming Mouse", 1, 89.99),
        OrderItem("Mechanical Keyboard", 1, 129.99),
      ],
    ),
    OrderModel(
      address: "Istanbul, Taksim Square, No. 14",
      description: "Office Furniture Set",
      date: "10/1/2024",
      status: OrderStatus.canceled,
      items: [
        OrderItem("Ergonomic Chair", 1, 349.99),
        OrderItem("Office Desk", 1, 199.99),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: myAppBar(title: "orders".tr, context: context),
      body: orders.isEmpty
          ? _buildEmptyState(theme)
          : ListView.separated(
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
              itemCount: orders.length,
              separatorBuilder: (_, __) => SizedBox(height: 12),
              itemBuilder: (context, index) {
                return _buildOrderCard(orders[index], theme, context);
              },
            ),
    );
  }

  Widget _buildEmptyState(ThemeData theme) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.shopping_bag_outlined,
              size: 80, color: Colors.grey.withOpacity(0.5)),
          SizedBox(height: 20),
          Text(
            "No Orders Yet",
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
            ),
          ),
          SizedBox(height: 10),
          Text(
            "Your orders will appear here",
            style: theme.textTheme.bodyMedium?.copyWith(
              color: Colors.grey[500],
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColor.kPrimaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            child: Text(
              "Start Shopping",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderCard(
      OrderModel order, ThemeData theme, BuildContext context) {
    final totalAmount = order.items
        .fold(0.0, (sum, item) => sum + (item.price * item.quantity));

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      margin: EdgeInsets.symmetric(horizontal: 8),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          // Navigate to order details
        },
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Order Header
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColor.kPrimaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child:
                        Icon(Icons.shopping_bag, color: AppColor.kPrimaryColor),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Order #${orders.indexOf(order) + 1001}",
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          order.date,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                  _buildStatusBadge(order.status),
                ],
              ),
              SizedBox(height: 16),

              // Order Summary
              Text(
                "${order.items.length} ${order.items.length > 1 ? 'items' : 'item'} • \$${totalAmount.toStringAsFixed(2)}",
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 8),

              // First 2 items preview
              ...order.items.take(2).map((item) => Padding(
                    padding: EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      children: [
                        Text("•", style: TextStyle(color: Colors.grey)),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            "${item.name} x${item.quantity}",
                            style: theme.textTheme.bodyMedium,
                          ),
                        ),
                        Text(
                          "\$${(item.price * item.quantity).toStringAsFixed(2)}",
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  )),

              if (order.items.length > 2) ...[
                SizedBox(height: 4),
                Text(
                  "+ ${order.items.length - 2} more items",
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: AppColor.kPrimaryColor,
                  ),
                ),
              ],

              SizedBox(height: 16),
              Divider(height: 1),
              SizedBox(height: 12),

              // Footer with address and action button
              Row(
                children: [
                  Icon(Icons.location_on_outlined,
                      size: 16, color: Colors.grey[600]),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      order.address,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: Colors.grey[600],
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(width: 12),
                  OutlinedButton(
                    onPressed: () {
                      // View order details
                    },
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: AppColor.kPrimaryColor),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      "Details",
                      style: TextStyle(color: AppColor.kPrimaryColor),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusBadge(OrderStatus status) {
    final statusData = _getStatusData(status);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: statusData.color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(statusData.icon, size: 14, color: statusData.color),
          SizedBox(width: 6),
          Text(
            statusData.text,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: statusData.color,
            ),
          ),
        ],
      ),
    );
  }

  _StatusData _getStatusData(OrderStatus status) {
    switch (status) {
      case OrderStatus.delivered:
        return _StatusData(
          Icons.check_circle,
          "Delivered",
          Colors.green,
        );
      case OrderStatus.pending:
        return _StatusData(
          Icons.access_time,
          "Processing",
          Colors.orange,
        );
      case OrderStatus.canceled:
        return _StatusData(
          Icons.cancel,
          "Canceled",
          Colors.red,
        );
    }
  }
}

class _StatusData {
  final IconData icon;
  final String text;
  final Color color;

  _StatusData(this.icon, this.text, this.color);
}

class OrderModel {
  final String address;
  final String description;
  final String date;
  final OrderStatus status;
  final List<OrderItem> items;

  OrderModel({
    required this.address,
    required this.description,
    required this.date,
    required this.status,
    required this.items,
  });
}

class OrderItem {
  final String name;
  final int quantity;
  final double price;

  OrderItem(this.name, this.quantity, this.price);
}

enum OrderStatus { delivered, pending, canceled }
