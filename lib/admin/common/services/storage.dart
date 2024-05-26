import 'package:booking_doctor/main.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageServiceWeb extends ChangeNotifier {
  Future<StorageServiceWeb> init() async {
    prefWeb = await SharedPreferences.getInstance();
    return this;
  }

  Future<bool> setInt(String key, int value) async {
    return await prefWeb.setInt(key, value);
  }

  int getInt(String key) {
    return prefWeb.getInt(key) ?? 0;
  }

  Future<bool> setString(String key, String value) async {
    return await prefWeb.setString(key, value);
  }

  String getString(String key) {
    return prefWeb.getString(key) ?? "";
  }

  Future<bool> remove(String key) async {
    return await prefWeb.remove(key);
  }
}
