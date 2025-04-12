import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:shopping_app/core/constants/colors.dart';

class Orders extends StatelessWidget {
  Orders({super.key});
  static String id = "orders";

  final List<OrderModel> orders = [
    OrderModel(
      address: "Ashgabat, 1 Mkr, Ul. Swaboda, Dom №16A (Beki), 271496",
      description:
          "The Product Designer is responsible for articulating and conceptualizing our product.",
      date: "18/5/2021",
      status: OrderStatus.delivered,
    ),
    OrderModel(
      address: "New York, 45th Street, Apartment 12",
      description: "A high-quality gaming laptop with RTX 4090 GPU.",
      date: "22/7/2023",
      status: OrderStatus.pending,
    ),
    OrderModel(
      address: "Istanbul, Taksim Square, No. 14",
      description: "Premium leather office chair with ergonomic support.",
      date: "10/1/2024",
      status: OrderStatus.canceled,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("orders".tr),
        centerTitle: true,
        elevation: 8,
        shadowColor: Colors.black,
      ),
      body: orders.isEmpty
          ? Center(
              child: Text(
                "No Orders Available",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            )
          : ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 10),
              itemCount: orders.length,
              itemBuilder: (context, index) {
                return CustomOrderContainer(order: orders[index]);
              },
            ),
    );
  }
}

class CustomOrderContainer extends StatelessWidget {
  final OrderModel order;
  const CustomOrderContainer({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColor.kPrimaryColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(Icons.location_on, color: AppColor.kWhiteColor),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  order.address,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Text(
            order.description,
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
          Divider(),
          Row(
            children: [
              _buildStatusIcon(order.status),
              SizedBox(width: 5),
              Text(
                _getStatusText(order.status),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: _getStatusColor(order.status),
                ),
              ),
              Spacer(),
              Text(
                "📅 ${order.date}",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
              ),
            ],
          ),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {},
              child: Text(
                "View Details",
                style: TextStyle(
                  color: AppColor.kPrimaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(OrderStatus status) {
    switch (status) {
      case OrderStatus.delivered:
        return Colors.green;
      case OrderStatus.pending:
        return Colors.orange;
      case OrderStatus.canceled:
        return Colors.red;
    }
  }

  String _getStatusText(OrderStatus status) {
    switch (status) {
      case OrderStatus.delivered:
        return "Delivered";
      case OrderStatus.pending:
        return "Pending";
      case OrderStatus.canceled:
        return "Canceled";
    }
  }

  Icon _buildStatusIcon(OrderStatus status) {
    switch (status) {
      case OrderStatus.delivered:
        return Icon(Icons.check_circle, color: Colors.green);
      case OrderStatus.pending:
        return Icon(Icons.hourglass_bottom, color: Colors.orange);
      case OrderStatus.canceled:
        return Icon(Icons.cancel, color: Colors.red);
    }
  }
}

class OrderModel {
  final String address;
  final String description;
  final String date;
  final OrderStatus status;

  OrderModel({
    required this.address,
    required this.description,
    required this.date,
    required this.status,
  });
}

enum OrderStatus { delivered, pending, canceled }
