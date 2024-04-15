import 'package:shared_preferences/shared_preferences.dart';

import 'constant.dart';

class PreferencesApp{
  setAccessToken(String Token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("token", Token);
  }

  Future<String?> getAccessToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");
    return token;
  }
  
  getCurrentUser() {
    String? value  = sharedPreferences?.getString("userId");
    return value;
  }

  setIsNewUser(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("isNewUser", value);
  }

  Future<bool?> getIsNewUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? value = prefs.getBool("isNewUser");
    return value;
  }

  setIsProfileUpdated(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("isProfileUpdated", value);
  }

  Future<bool?> getIsProfileUpdated() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isProfileUpdated = prefs.getBool("isProfileUpdated");
    return isProfileUpdated;
  }

  removePreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
    prefs.remove('isNewUser');
    // prefs.remove('isProfileUpdated');
    // prefs.remove('roleType');
    //  prefs.remove('level');
  }
}