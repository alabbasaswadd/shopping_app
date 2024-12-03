import 'dart:convert';
import 'package:flutter/services.dart';

class TranslationService {
  static Map<String, dynamic>? _localizedStrings;

  /// تحميل ملف الترجمة من JSON بناءً على اللغة المحددة
  static Future<void> load(String locale) async {
    String jsonString =
        await rootBundle.loadString('assets/localaizations/ar.json');
    Map<String, dynamic> jsonMap = json.decode(jsonString);
    _localizedStrings = jsonMap[locale];
  }

  /// الحصول على النص المترجم بناءً على المفتاح
  static String translate(String key) {
    return _localizedStrings?[key] ?? key;
  }
}
