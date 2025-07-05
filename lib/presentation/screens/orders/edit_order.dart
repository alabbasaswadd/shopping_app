import 'package:flutter/material.dart';
import 'package:shopping_app/data/model/order/order_data_model.dart';

class EditOrderPage extends StatelessWidget {
  final OrderDataModel order;

  const EditOrderPage({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text("تعديل الطلب #${order.id}"),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_rounded),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            // بطاقة عرض البيانات الحالية
            _buildOrderCard(context),
            SizedBox(height: 30),
            // نموذج التعديل
            _buildEditForm(context),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderCard(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [
                Icon(Icons.info_outline_rounded, color: Colors.blue[700]),
                SizedBox(width: 10),
                Text("معلومات الطلب الحالية",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    )),
              ],
            ),
            SizedBox(height: 20),
            _buildInfoRow("رقم الطلب", "#${order.id}"),
            _buildInfoRow("حالة الطلب", order.orderState ?? "غير معروف"),
            _buildInfoRow("المتجر", order.shopId ?? "غير معروف"),
            _buildInfoRow("التاريخ", order.orderDate ?? "asd"),
            _buildInfoRow("المبلغ الإجمالي",
                "${order.totalAmount?.toStringAsFixed(2) ?? "0.00"} ر.س"),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String title, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Text(
            "$title: ",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.grey[700],
            ),
          ),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: TextStyle(
                color: Colors.grey[800],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEditForm(BuildContext context) {
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "تعديل البيانات",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20),
          TextFormField(
            decoration: InputDecoration(
              labelText: "حالة الطلب",
              prefixIcon: Icon(Icons.edit_outlined),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              filled: true,
              fillColor: Colors.grey[100],
            ),
            initialValue: order.orderState,
          ),
          SizedBox(height: 15),
          TextFormField(
            decoration: InputDecoration(
              labelText: "ملاحظات",
              prefixIcon: Icon(Icons.note_alt_outlined),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              filled: true,
              fillColor: Colors.grey[100],
            ),
            maxLines: 3,
          ),
          SizedBox(height: 25),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 3,
              ),
              onPressed: () {
                // حفظ التعديلات
                _saveChanges(context);
              },
              child: Text(
                "حفظ التعديلات",
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _saveChanges(BuildContext context) {
    // هنا كود حفظ التعديلات
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("تم حفظ التعديلات بنجاح"),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
    Navigator.pop(context);
  }
}
