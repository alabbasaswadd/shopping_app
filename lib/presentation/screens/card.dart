import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shopping_app/core/constants/colors.dart';
import 'package:shopping_app/presentation/screens/payment.dart';
import 'package:shopping_app/presentation/widget/products/products_body.dart';

class CardPage extends StatefulWidget {
  const CardPage({super.key});
  static String id = "card";

  @override
  State<CardPage> createState() => _CardPageState();
}

class _CardPageState extends State<CardPage> {
  double _totalPrice = 0.0;

  @override
  void initState() {
    super.initState();
    calculateTotalPrice();
  }

  void calculateTotalPrice() {
    setState(() {
      _totalPrice = ProductsBody.productsCard
          .fold(0.0, (sum, item) => sum + ((item.price) * item.quantity));
    });
  }

  void increaseQuantity(int index) {
    setState(() {
      ProductsBody.productsCard[index].quantity += 1;
      calculateTotalPrice();
    });
  }

  void decreaseQuantity(int index) {
    setState(() {
      if (ProductsBody.productsCard[index].quantity > 1) {
        ProductsBody.productsCard[index].quantity--;
        calculateTotalPrice();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("card".tr),
        centerTitle: true,
        elevation: 8,
        shadowColor: Colors.black,
      ),
      body: ProductsBody.productsCard.isEmpty
          ? Center(child: Text("no_products_in_card".tr))
          : ListView.builder(
              itemCount: ProductsBody.productsCard.length,
              itemBuilder: (context, i) {
                return Container(
                  padding: EdgeInsets.all(5),
                  height: 142,
                  margin: EdgeInsets.symmetric(vertical: 5),
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: double.infinity,
                        width: 100,
                        child: Image.network(
                          ProductsBody.productsCard[i].image,
                          fit: BoxFit.fill,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Text(
                                ProductsBody.productsCard[i].title,
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                            ),
                            Text(
                              "${ProductsBody.productsCard[i].price} ₺",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () {
                              Fluttertoast.showToast(
                                  msg: "Removed From Card",
                                  backgroundColor: AppColor.kRedColor);
                              setState(() {
                                ProductsBody.productsCard
                                    .removeAt(i);
                                calculateTotalPrice(); // تحديث الإجمالي بعد الحذف
                              });
                            },
                            icon: const Icon(Icons.remove_shopping_cart,
                                color: Colors.red),
                          ),
                          Row(
                            children: [
                              IconButton(
                                  onPressed: () => decreaseQuantity(i),
                                  icon: Icon(Icons.remove)),
                              Text(
                                "${ProductsBody.productsCard[i].quantity}",
                                style: TextStyle(fontSize: 16),
                              ),
                              IconButton(
                                  onPressed: () => increaseQuantity(i),
                                  icon: Icon(Icons.add)),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
      bottomNavigationBar: Container(
        color: Theme.of(context).colorScheme.secondary,
        padding: EdgeInsets.all(3),
        height: 80,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Text(
                  "total: ${_totalPrice.toStringAsFixed(2)} ₺",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              MaterialButton(
                color: AppColor.kPrimaryColor,
                textColor: Colors.white,
                onPressed: () {
                  Get.toNamed(Payment.id);
                },
                child: Text("payment".tr),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
