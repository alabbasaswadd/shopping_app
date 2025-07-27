import 'package:flutter/material.dart';
import 'package:shopping_app/presentation/screens/chat.dart';
import 'package:shopping_app/presentation/screens/about.dart';
import 'package:shopping_app/presentation/screens/account.dart';
import 'package:shopping_app/presentation/screens/cart.dart';
import 'package:shopping_app/presentation/screens/change_password_screen.dart';
import 'package:shopping_app/presentation/screens/cubit/splash_screen.dart';
import 'package:shopping_app/presentation/screens/delivery_company.dart';
import 'package:shopping_app/presentation/screens/offers.dart';
import 'package:shopping_app/presentation/screens/cubit/onboarding_screen.dart';
import 'package:shopping_app/presentation/screens/orders/orders.dart';
import 'package:shopping_app/presentation/screens/products/product_details.dart';
import 'package:shopping_app/presentation/screens/products/products.dart';
import 'package:shopping_app/presentation/screens/settings.dart';
import 'package:shopping_app/presentation/screens/shops/shops.dart';
import 'presentation/screens/favorite.dart';
import 'presentation/screens/payment.dart';
import 'presentation/screens/auth/signup.dart';
import 'presentation/screens/auth/login.dart';
import 'presentation/screens/home_screen.dart';
import 'presentation/screens/notifications.dart';
import 'presentation/screens/onboarding.dart';
import 'presentation/screens/splash.dart';

Map<String, Widget Function(BuildContext)> routes = {
  Login.id: (context) => Login(),
  Shops.id: (context) => Shops(),
  Offers.id: (context) => Offers(),
  Payment.id: (context) => Payment(),
  SignUp.id: (context) => SignUp(),
  Account.id: (context) => Account(),
  Orders.id: (context) => Orders(),
  About.id: (context) => About(),
  Settings.id: (context) => Settings(),
  Productes.id: (context) => Productes(),
  Favorite.id: (context) => Favorite(),
  ProductDetails.id: (context) => ProductDetails(),
  CartPage.id: (context) => CartPage(),
  Notifications.id: (context) => Notifications(),
  HomeScreen.id: (context) => HomeScreen(),
  Onboarding.id: (context) => Onboarding(),
  // OnboardingScreen.id: (context) => OnboardingScreen(),
  SplashScreen.id: (context) => SplashScreen(),
  ChatScreen.id: (context) => ChatScreen(),
  Splash.id: (context) => Splash(),
  ChangePasswordScreen.id: (context) => ChangePasswordScreen(),
  DeliveryCompanySelection.id: (context) => DeliveryCompanySelection(),
};
