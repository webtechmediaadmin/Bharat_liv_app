import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

String DATA_KEY = "data";
String STATUS_KEY = "status";
String ERROR_KEY = "error";

class MyConstant {
  static int? AppLanguage = 0;
  static String mobileNumber = "";
  static String kycCameraName = "";
  static String mediaType = "";
  static int parent_id = 0;
  static String appText = "";
  static String isLogin= "isLogin";
  static bool? isNewUser;
  static bool? isProfileUpdated;
  static int? userId;
  static String access_token = "";
  static bool? isFavoriteSet = false;
}

SharedPreferences? sharedPreferences;



bool isValidPhoneNumber(String string) {
  // Null or empty string is invalid phone number
  if (string.isEmpty) {
    return false;
  }
  // You may need to change this pattern to fit your requirement.
  // I just copied the pattern from here: https://regexr.com/3c53v
  const pattern = r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$';
  final regExp = RegExp(pattern);

  if (!regExp.hasMatch(string)) {
    return false;
  }
  return true;
}

 void showToast(text) {
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_SHORT, // Duration for which the toast should be shown
      gravity: ToastGravity.BOTTOM, // Position of the toast message on the screen
      backgroundColor: Colors.black.withOpacity(0.7), // Background color of the toast message
      textColor: Colors.white, // Text color of the toast message
      fontSize: 16.0, // Font size of the toast message
    );
  }
