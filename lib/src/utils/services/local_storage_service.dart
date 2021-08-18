import 'package:hero_flutter/src/constants/app_setting.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  LocalStorageService._internal();

  static final LocalStorageService _instance = LocalStorageService._internal();

  factory LocalStorageService() => _instance;

  Future<void> setUserInfo(String username, token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(AppSetting.username, username);
    prefs.setString(AppSetting.token, token);
  }

  Future<String> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(AppSetting.token) ?? '';
  }

  Future<String> getUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(AppSetting.username) ?? '';
  }

  Future<void> removeToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // prefs.clear();
    prefs.remove(AppSetting.token);
  }
}
