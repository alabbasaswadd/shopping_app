import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/business_logic/cubit/products/products_cubit.dart';
import 'package:shopping_app/data/repository/products_repository.dart';
import 'package:shopping_app/data/web_services/products_web_services.dart';
import 'package:shopping_app/presentation/screens/about.dart';
import 'package:shopping_app/presentation/screens/account.dart';
import 'package:shopping_app/presentation/screens/card.dart';
import 'package:shopping_app/presentation/screens/orders.dart';
import 'package:shopping_app/presentation/screens/produc_details.dart';
import 'package:shopping_app/presentation/screens/products.dart';
import 'package:shopping_app/presentation/screens/settings.dart';
import 'presentation/screens/favorite.dart';
import 'progres.dart';
import 'presentation/screens/login.dart';
import 'presentation/screens/home_screen.dart';
import 'presentation/screens/notifications.dart';
import 'presentation/screens/onboarding.dart';
import 'presentation/screens/splash.dart';

Map<String, Widget Function(BuildContext)> routes = {
  Login.id: (context) => Login(),
  Account.id: (context) => Account(),
  Orders.id: (context) => Orders(),
  About.id: (context) => About(),
  Settings.id: (context) => Settings(),
  Productes.id: (context) => Productes(),
  Favorite.id: (context) => Favorite(),
  ProdutDetails.id: (context) => ProdutDetails(),
  CardPage.id: (context) => CardPage(),
  Notifications.id: (context) => Notifications(),
  Progres.id: (context) => Progres(),
  HomeScreen.id: (context) => HomeScreen(),
  Onboarding.id: (context) => Onboarding(),
  Splash.id: (context) => Splash(),
};
