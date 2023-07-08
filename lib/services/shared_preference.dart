import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceService {
  static void saveData(String key, dynamic value) async {
    final pref = await SharedPreferences.getInstance();
    if (value is int) {
      pref.setInt(key, value);
    }
    if (value is String) {
      pref.setString(key, value);
    }
    if (value is bool) {
      pref.setBool(key, value);
    } else {
      if (kDebugMode) {
        print("other types are not supported");
      }
    }
  }

  static Future<dynamic> readData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    dynamic obj = prefs.get(key);
    return obj;
  }

  static Future<bool> deleteData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.remove(key);
  }
}
