import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefRepo {
  static late SharedPreferences sharedPreferences;

  static const String isAlreadyLogin = "isAlreadyLogin";
  static const String userId = "userId";
  static const String token = "token";
  static const String email = "email";
  static const String userType = "userType";

  static Future<void> initSharedPref() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<void> saveData(String key, dynamic value) async {
    if (value is String) {
      await sharedPreferences.setString(key, value);
    } else if (value is bool) {
      await sharedPreferences.setBool(key, value);
    } else if (value is int) {
      await sharedPreferences.setInt(key, value);
    } else if (value is double) {
      await sharedPreferences.setDouble(key, value);
    }
  }

  static Future<dynamic> readData(String key) async {
    return sharedPreferences.get(key);
  }

  static Future<void> clearSharedPref() async {
    await sharedPreferences.clear();
  }
}
