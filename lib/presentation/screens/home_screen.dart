import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/presentation/screens/account.dart';
import 'package:shopping_app/presentation/screens/offers.dart';
import 'package:shopping_app/presentation/screens/orders/orders.dart';
import 'package:shopping_app/presentation/screens/products/products.dart';
import 'package:shopping_app/presentation/screens/shops/shops.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static String id = "homeScreen";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 2;
  final List<Widget> pages = [
    // OnboardingScreen(),
    Shops(),
    const Offers(),
    const Productes(),
    Orders(),
    Account(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            selectedIndex = 2;
          });
        },
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: const Icon(
          Icons.home,
          size: 30,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      body: pages[selectedIndex],
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
        notchSmoothness: NotchSmoothness.smoothEdge,
        leftCornerRadius: 30,
        rightCornerRadius: 30,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        backgroundColor: Theme.of(context).colorScheme.secondary,
        activeColor: Theme.of(context).colorScheme.primary,
        inactiveColor: Colors.grey,
      ),
    );
  }
}
