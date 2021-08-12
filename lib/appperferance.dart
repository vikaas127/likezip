import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {
  static Future<bool> remove(String key) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.remove(key);
  }

  // Getter
  static Future<int> getInt(String key) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getInt(key) ?? 0;
  }

  static Future<bool> getBool(String key) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getBool(key) ?? false;
  }

  static Future<double> getDouble(String key) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getDouble(key) ?? 0.0;
  }

  static Future<String> getString(String key) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(key) ?? null;
  }

  static Future<List<String>> getStringList(String key) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    // ignore: deprecated_member_use
    return preferences.getStringList(key) ?? List<String>(0);
  }

  // Setter
  static Future<bool> setInt(String key, int value) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.setInt(key, value);
  }

  static Future<bool> setBool(String key, bool value) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.setBool(key, value);
  }

  static Future<bool> setDouble(String key, double value) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.setDouble(key, value);
  }

  static Future<bool> setString(String key, String value) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.setString(key, value);
  }

  static Future<bool> setStringList(String key, List<String> value) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.setStringList(key, value);
  }
}
