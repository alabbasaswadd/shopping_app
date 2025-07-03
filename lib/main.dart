import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_app/core/constants/functions.dart';
import 'package:shopping_app/core/localization/translation.dart';
import 'package:shopping_app/data/model/user/user_data_model.dart';
import 'package:shopping_app/data/repository/products_repository.dart';
import 'package:shopping_app/data/web_services/web_services.dart';
import 'package:shopping_app/presentation/business_logic/cubit/auth/auth_cubit.dart';
import 'package:shopping_app/presentation/business_logic/cubit/products/products_cubit.dart';
import 'package:shopping_app/presentation/business_logic/cubit/searching/searching_cubit.dart';
import 'package:shopping_app/core/constants/theme.dart';
import 'package:shopping_app/presentation/screens/splash.dart';
import 'routes.dart';

late String savedLanguage;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await UserSession.init(); // تحميل بيانات المستخدم من SharedPreferences
  SharedPreferences prefs = await SharedPreferences.getInstance();
  savedLanguage = prefs.getString('language') ?? 'ar';
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => SearchingCubit()),
        BlocProvider(create: (context) => ProductsCubit()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: lightTheme,
      dark: darkTheme,
      initial: AdaptiveThemeMode.light,
      builder: (theme, darkTheme) => GetMaterialApp(
        localizationsDelegates: const [
          GlobalWidgetsLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en', ''),
          Locale('ar', ''),
        ],
        locale: Locale(savedLanguage),
        translations: AppTranslations(),
        theme: theme,
        darkTheme: darkTheme,
        routes: routes,
        debugShowCheckedModeBanner: false,
        initialRoute: Splash.id,
      ),
    );
  }
}
