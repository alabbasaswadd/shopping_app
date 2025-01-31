import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/presentation/screens/login.dart';
import 'package:shopping_app/presentation/screens/produc_details.dart';
import 'package:shopping_app/presentation/screens/products.dart';
import 'package:shopping_app/presentation/screens/settings.dart';

import 'signup.dart'; // تأكد من المسار

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static String id = "homeScreen";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0; // لتحديد الصفحة الحالية
  final List<Widget> pages = [
    const Productes(),
    Login(),
    const Settings(), // الصفحة الثانية (Settings)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[selectedIndex], // إظهار الصفحة المحددة بناءً على الـ index
      bottomNavigationBar: AnimatedBottomNavigationBar(
        icons: const [
          Icons.home,
          Icons.production_quantity_limits,
          Icons.settings,
        ],
        activeIndex: selectedIndex,
        gapLocation: GapLocation.none, // تغيير gapLocation إلى end
        notchSmoothness: NotchSmoothness.smoothEdge,
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
