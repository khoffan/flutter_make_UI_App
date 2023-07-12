import 'package:shared_preferences/shared_preferences.dart';

class Users{
  static Future<bool?> getLogin() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getBool("Log-in");
  }
  static Future<void> setLogin(bool value) async {
      SharedPreferences pref = await SharedPreferences.getInstance();
      await pref.setBool("Log-in", value);
  }
}