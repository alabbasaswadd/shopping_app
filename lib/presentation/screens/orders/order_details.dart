import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:shopping_app/core/constants/colors.dart';
import 'package:shopping_app/core/widgets/my_app_bar.dart';
import 'package:shopping_app/core/widgets/my_text.dart';
import 'package:shopping_app/data/model/order/order_data_model.dart';

class OrderDetails extends StatefulWidget {
  final OrderDataModel order;

  const OrderDetails({super.key, required this.order});

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  // متغيرات حالة التوسيع لكل قسم
  bool _orderInfoExpanded = true;
  bool _shopInfoExpanded = true;
  bool _productsExpanded = true;
  @override
  void initState() {
    print(widget.order.orderItems![0].price);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final orderDate =
        DateTime.parse(widget.order.orderDate ?? DateTime.now().toString());
    final formattedDate =
        '${orderDate.day}/${orderDate.month}/${orderDate.year}';

    return Scaffold(
      appBar: myAppBar(context: context, title: "orders".tr),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildAnimatedSection(
              title: "معلومات الطلب",
              expanded: _orderInfoExpanded,
              onTap: () =>
                  setState(() => _orderInfoExpanded = !_orderInfoExpanded),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInfoRow(
                      "رقم الطلب", widget.order.id?.substring(0, 8) ?? "N/A"),
                  _divider(),
                  _buildInfoRow("تاريخ الطلب", formattedDate),
                  //_buildInfoRow("الحالة", _getOrderStateText(widget.order.orderState)),
                  _divider(),
                  _buildInfoRow("المجموع",
                      "${widget.order.totalAmount?.toStringAsFixed(2) ?? 0} ر.س"),
                ],
              ),
            ),
            const SizedBox(height: 20),
            _buildAnimatedSection(
              title: "معلومات المتجر",
              expanded: _shopInfoExpanded,
              onTap: () =>
                  setState(() => _shopInfoExpanded = !_shopInfoExpanded),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInfoRow("اسم المتجر",
                      "${widget.order.shop?.firstName ?? "N/A"} ${widget.order.shop?.lastName ?? ""}"),
                  _divider(),
                  _buildInfoRow(
                      "هاتف المتجر", widget.order.shop?.phone ?? "N/A"),
                ],
              ),
            ),
            const SizedBox(height: 20),
            _buildAnimatedSection(
              title: "المنتجات",
              expanded: _productsExpanded,
              onTap: () =>
                  setState(() => _productsExpanded = !_productsExpanded),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (widget.order.orderItems == null ||
                      widget.order.orderItems!.isEmpty)
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 12.0),
                      child: CairoText("لا توجد منتجات"),
                    )
                  else
                    ...widget.order.orderItems!.map(
                      (item) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          children: [
                            const Icon(Icons.shopping_bag, size: 20),
                            const SizedBox(width: 8),
                            Expanded(
                              child: CairoText(
                                item.productName ?? "N/A",
                              ),
                            ),
                            CairoText(
                                "${item.price?.toStringAsFixed(2) ?? "0.00"}"),
                            const SizedBox(width: 12),
                            CairoText("× ${item.quantity ?? 1}"),
                          ],
                        ),
                      ),
                    ),
                  const Divider(height: 32, thickness: 1),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const CairoText(
                        "الإجمالي النهائي:",
                      ),
                      CairoText(
                        "${widget.order.totalAmount?.toStringAsFixed(2) ?? 0} ر.س",
                        color: AppColor.kPrimaryColor,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnimatedSection({
    required String title,
    required bool expanded,
    required VoidCallback onTap,
    required Widget child,
  }) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          ListTile(
            title: CairoText(
              title,
              color: AppColor.kPrimaryColor,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            trailing: Icon(
              expanded ? Icons.expand_less : Icons.expand_more,
              color: Colors.grey[600],
            ),
            onTap: onTap,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          ),
          AnimatedCrossFade(
            firstChild: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: child,
            ),
            secondChild: Container(),
            duration: const Duration(milliseconds: 300),
            crossFadeState:
                expanded ? CrossFadeState.showFirst : CrossFadeState.showSecond,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          CairoText(
            "$label: ",
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: CairoText(value),
          ),
        ],
      ),
    );
  }

  Widget _divider() => const Divider(height: 16, thickness: 1);

  String _getOrderStateText(int? state) {
    switch (state) {
      case 0:
        return "قيد الانتظار";
      case 1:
        return "قيد التجهيز";
      case 2:
        return "تم الشحن";
      case 3:
        return "تم التسليم";
      case 4:
        return "ملغي";
      default:
        return "غير معروف";
    }
  }
}
