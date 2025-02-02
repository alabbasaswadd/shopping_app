import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/presentation/screens/account.dart';
import 'package:shopping_app/presentation/screens/login.dart';
import 'package:shopping_app/presentation/screens/offers.dart';
import 'package:shopping_app/presentation/screens/orders.dart';
import 'package:shopping_app/presentation/screens/produc_details.dart';
import 'package:shopping_app/presentation/screens/products.dart';
import 'package:shopping_app/presentation/screens/settings.dart';
import 'package:shopping_app/presentation/screens/stores.dart';
import 'signup.dart'; // تأكد من المسار

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static String id = "homeScreen";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 2; // لتحديد الصفحة الحالية
  final List<Widget> pages = [
    const Stores(),
    const Offers(),
    const Productes(),
    Orders(),
    const Account(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            selectedIndex = 2; // اجعل الصفحة الوسطى هي الرئيسية
          });
        },
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: const Icon(
          Icons.home,
          size: 30,
          color: Colors.white,
        ), // الأيقونة العائمة
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.centerDocked, // تحديد موقع الزر العائم

      body: pages[selectedIndex], // إظهار الصفحة المحددة بناءً على الـ index

      bottomNavigationBar: AnimatedBottomNavigationBar(
        icons: const [
          Icons.store,
          Icons.percent,
          Icons.home,
          Icons.list,
          Icons.person,
        ],
        activeIndex: selectedIndex,
        gapLocation: GapLocation.none,
        notchSmoothness: NotchSmoothness.verySmoothEdge,
        leftCornerRadius: 32,
        rightCornerRadius: 32,

        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        backgroundColor:
            Theme.of(context).colorScheme.secondary, // تخصيص اللون الخلفي
        activeColor: Theme.of(context).colorScheme.primary, // تخصيص اللون النشط
        inactiveColor: Colors.grey,
        // تخصيص اللون الغير نشط
      ),
    );
  }
}
