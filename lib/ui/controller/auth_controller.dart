import 'dart:convert';

import '../../data/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController {
  static const String _accessTokenKey = 'token';
  static const String _userModelKey = 'token';

  static String? accessToken;
  static UserModel? userModel;

  static Future<void> saveUserData(UserModel model, String token) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(_accessTokenKey, token);
    await sharedPreferences.setString(
        _userModelKey, jsonEncode(model.toJason()));

    accessToken = token;
    userModel = model;
  }
  static Future<void> updateUserData(UserModel model) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(
        _userModelKey, jsonEncode(model.toJason()));

   // accessToken = token;
    userModel = model;
  }
  static Future<void> getUserData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString(_accessTokenKey);
    if (token != null) {
      String? userData = sharedPreferences.getString(_userModelKey);
      userModel = UserModel.fromJson(jsonDecode(userData!));
      accessToken = token;
    }
  }

  static Future<bool> isUserLoggedIn() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString(_accessTokenKey);
    if (token != null) {
      return true;
    } else {
      return false;
    }
  }

  static Future<void> clearData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();
  }
}
