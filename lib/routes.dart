import 'package:flutter/material.dart';
import 'package:shopping_app/presentation/screens/about.dart';
import 'package:shopping_app/presentation/screens/account.dart';
import 'package:shopping_app/presentation/screens/card.dart';
import 'package:shopping_app/presentation/screens/offers.dart';
import 'package:shopping_app/presentation/screens/orders.dart';
import 'package:shopping_app/presentation/screens/produc_details.dart';
import 'package:shopping_app/presentation/screens/products.dart';
import 'package:shopping_app/presentation/screens/settings.dart';
import 'package:shopping_app/presentation/screens/stores.dart';
import 'presentation/screens/favorite.dart';
import 'presentation/screens/payment.dart';
import 'presentation/screens/signup.dart';
import 'presentation/screens/login.dart';
import 'presentation/screens/home_screen.dart';
import 'presentation/screens/notifications.dart';
import 'presentation/screens/onboarding.dart';
import 'presentation/screens/splash.dart';

Map<String, Widget Function(BuildContext)> routes = {
  Login.id: (context) => Login(),
  Stores.id: (context) => Stores(),
  Offers.id: (context) => Offers(),
  Payment.id: (context) => Payment(),
  SignUp.id: (context) => SignUp(),
  Account.id: (context) => Account(),
  Orders.id: (context) => Orders(),
  About.id: (context) => About(),
  Settings.id: (context) => Settings(),
  Productes.id: (context) => Productes(),
  Favorite.id: (context) => Favorite(),
  ProdutDetails.id: (context) => ProdutDetails(),
  CardPage.id: (context) => CardPage(),
  Notifications.id: (context) => Notifications(),
  HomeScreen.id: (context) => HomeScreen(),
  Onboarding.id: (context) => Onboarding(),
  Splash.id: (context) => Splash(),
};
