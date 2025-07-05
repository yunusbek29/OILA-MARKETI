import 'dart:convert';

import 'package:flutter_application_1/data/repository/models/product_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static Future<void> setBool(String key, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }

  static Future<bool?> getBool(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key);
  }

  static Future<void> setInt(String key, int value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(key, value);
  }

  static Future<int?> getInt(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(key);
  }

  static Future<void> setString(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  static Future<String?> getString(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  static Future<void> setStringList(String key, List<String> value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(key, value);
  }

  static Future<List<String>?> getStringList(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(key);
  }

  static Future<void> remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }

  static Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  Future<void> saveIntList(String key, List<int> intList) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    List<String> stringList = intList.map((e) => e.toString()).toList();
    await pref.setStringList(key, stringList);
  }

  Future<List<int>> getIntList(String key) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    List<String>? stringList = pref.getStringList(key);
    if (stringList == null) return [];
    return stringList.map((e) => int.tryParse(e) ?? 0).toList();
  }

  Future<List<ProductModel>> getProductList(String key) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    List<String>? encodedList = pref.getStringList(key);
    if (encodedList == null) return [];
    return encodedList
        .map((item) => ProductModel.fromJson(jsonDecode(item)))
        .toList();
  }

  Future<void> saveProductList(String key, List<ProductModel> product) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (product.isEmpty) {
      await prefs.remove(key);
      return;
    }
    List<String> encodedList = product
        .map((item) => jsonEncode(item.toJson()))
        .toList();
    await prefs.setStringList(key, encodedList);
  }
}
