import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_app/core/constants/cached/cached_helper.dart';
import 'package:shopping_app/core/constants/functions.dart';
import 'package:shopping_app/core/localization/translation.dart';
import 'package:shopping_app/core/constants/theme.dart';
import 'package:shopping_app/presentation/screens/splash.dart';
import 'package:showcaseview/showcaseview.dart';
import 'routes.dart';

late String savedLanguage;

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();

  print("🔔 رسالة واردة في الخلفية: ${message.messageId}");
}

void requestPermissionAndPrintToken() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  // طلب صلاحيات الإشعارات (مطلوب على iOS وأندرويد 13+)
  NotificationSettings settings = await messaging.requestPermission();

  if (settings.authorizationStatus == AuthorizationStatus.authorized ||
      settings.authorizationStatus == AuthorizationStatus.provisional) {
    // جلب التوكن
    String? token = await messaging.getToken();
    await CacheHelper.setString("tokenFCM", token ?? "");
    print('📱 FCM Token: $token');
  } else {
    print('🚫 المستخدم رفض صلاحيات الإشعارات');
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  requestPermissionAndPrintToken();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await UserSession.init(); // تحميل بيانات المستخدم من SharedPreferences
  SharedPreferences prefs = await SharedPreferences.getInstance();
  savedLanguage = prefs.getString('language') ?? 'ar';
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp, // الوضع الرأسي الطبيعي فقط
    // DeviceOrientation.portraitDown,  // لو تريد السماح بالعكس الرأسي أيضاً (اختياري)
  ]).then((_) {
    runApp(
      ScreenUtilInit(
        designSize: const Size(392, 825), // حجم التصميم الأساسي عندك
        minTextAdapt: true,
        builder: (context, child) {
          return ShowCaseWidget(
            builder: (context) => DevicePreview(
              enabled: false, // اجعلها false في الإنتاج
              builder: (context) => const MyApp(),
            ),
          );
        },
      ),
    );
  });
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
        useInheritedMediaQuery: true,
        builder: DevicePreview.appBuilder,
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
