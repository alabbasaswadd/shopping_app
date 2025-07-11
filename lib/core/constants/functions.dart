import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_app/core/constants/colors.dart';
import 'package:shopping_app/data/model/login/login_response_model.dart';
import 'package:shopping_app/data/model/user/user_data_model.dart';

class UserPreferencesService {
  static const String _userKey = 'user_data';

  // حفظ بيانات المستخدم (JSON String)
  static Future<void> saveUser(Map<String, dynamic> userJson) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userKey, jsonEncode(userJson));
  }

  // استرجاع بيانات المستخدم كخريطة
  static Future<Map<String, dynamic>?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userString = prefs.getString(_userKey);
    if (userString != null) {
      return jsonDecode(userString);
    }
    return null;
  }

  static Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("token", token);
  }

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");
    if (token != null) {
      return token;
    }
    return null;
  }

  // استرجاع قيمة معينة من بيانات المستخدم
  static Future<String?> getUserValue(String key) async {
    final user = await getUser();
    if (user != null && user.containsKey(key)) {
      return user[key].toString();
    }
    return null;
  }

  // حذف بيانات المستخدم
  static Future<void> clearUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userKey);
  }

  // هل المستخدم مسجل دخول؟
  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(_userKey);
  }

  // استرجاع بيانات المستخدم كنموذج UserModel
  static Future<UserDataModel?> getUserModel() async {
    final prefs = await SharedPreferences.getInstance();
    final userString = prefs.getString(_userKey);
    if (userString != null) {
      final json = jsonDecode(userString);
      return UserDataModel.fromJson(json);
    }
    return null;
  }
}

class UserSession {
  static UserDataModel? _user;

  /// تحميل بيانات المستخدم من SharedPreferences وتخزينها في الذاكرة
  static Future<void> init() async {
    _user = await UserPreferencesService.getUserModel();
  }

  /// كل بيانات المستخدم
  static UserDataModel? get user => _user;

  /// خصائص مباشرة من _user
  static String? get id => _user?.id;
  static String? get shoppingCartId => _user?.shoppingCartId;
  static String? get birthDate => _user?.dateOfBirth;
  static String? get firstName => _user?.firstName;
  static String? get lastName => _user?.lastName;
  static String? get phone => _user?.phone;
  static String? get city => _user?.address?.city;
  static String? get apartment => _user?.address?.apartment;
  static String? get street => _user?.address?.street;
  static String? get floor => _user?.address?.floor;

  // افترض هنا أن email من نوع String، عدل حسب نوعه الحقيقي
  static String? get email => _user?.email?.userName;

  // إذا الجنس عدد صحيح 0 أو 1

  /// هل المستخدم مسجل دخول؟
  static bool get isLoggedIn => _user != null;

  /// تحديث بيانات المستخدم
  static Future<void> updateUser(UserDataModel userModel) async {
    _user = userModel;
    await UserPreferencesService.saveUser(userModel.toJson());
  }

  /// تسجيل الخروج
  static Future<void> clear() async {
    _user = null;
    await UserPreferencesService.clearUser();
  }
}

Widget buildSectionHeader(String title) {
  return Text(
    title,
    style: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: AppColor.kPrimaryColor,
    ),
  );
}

Future<DateTime?> showDateDialog(BuildContext context) async {
  DateTime? pickedDate = await showDatePicker(
    context: context,
    initialDate: DateTime.now().subtract(Duration(days: 365 * 18)),
    firstDate: DateTime(1900),
    lastDate: DateTime.now(),
    helpText: 'select_birth_date'.tr,
    cancelText: 'cancel'.tr,
    confirmText: 'confirm'.tr,
    builder: (context, child) {
      return Theme(
        data: Theme.of(context).copyWith(
          colorScheme: ColorScheme.light(
            primary: AppColor.kPrimaryColor, // لون اليوم المختار وخلفية الزر
            onPrimary:
                Colors.white, // لون النص فوق اللون الأساسي (اليوم المحدد)
            onSurface: Colors.black, // لون النص العادي
          ),
          dialogBackgroundColor: Colors.white,
        ),
        child: child!,
      );
    },
  );
  return pickedDate;
}
