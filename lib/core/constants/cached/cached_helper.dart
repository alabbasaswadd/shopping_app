import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static SharedPreferences? _pref;

  static Future<SharedPreferences> get pref async {
    if (_pref == null) {
      SharedPreferences instance = await SharedPreferences.getInstance();
      _pref = instance;
      return instance;
    }
    return _pref!;
  }

  static Future<bool> containsKey(String key) async {
    final instance = await pref;
    return instance.containsKey(key);
  }

  static Future<bool> setString(String key, String value) async {
    final instance = await pref;
    return await instance.setString(key, value);
  }

  static Future<String> getString(String key) async {
    final instance = await pref;
    return instance.getString(key) ?? "";
  }

  static Future<bool> setInt(String key, int value) async {
    final instance = await pref;
    return await instance.setInt(key, value);
  }

  static Future<int> getInt(String key) async {
    final instance = await pref;
    return instance.getInt(key) ?? -1;
  }

  static Future<bool> setDouble(String key, double value) async {
    final instance = await pref;
    return await instance.setDouble(key, value);
  }

  static Future<double> getDouble(String key) async {
    final instance = await pref;
    return instance.getDouble(key) ?? -0.1;
  }

  static Future<bool> setBool(String key, bool value) async {
    final instance = await pref;
    return await instance.setBool(key, value);
  }

  static Future<bool?> getBool(String key) async {
    final instance = await pref;
    return instance.getBool(key);
  }

  static Future<bool> setStringList(String key, List<String> value) async {
    final instance = await pref;
    return await instance.setStringList(key, value);
  }

  static Future<List<String>> getStringList(String key) async {
    final instance = await pref;
    return instance.getStringList(key) ?? [];
  }

  static Future<bool> remove(String key) async {
    final instance = await pref;
    return instance.remove(key);
  }

  // ~ disposers
  static Future<bool> clearInstance(String key) async {
    final instance = await pref;
    return instance.clear();
    }
}