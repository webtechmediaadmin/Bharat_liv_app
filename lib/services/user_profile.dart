import 'dart:convert';
import 'dart:io';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../constant/constant.dart';
import '../models/user_profile.dart';
import '../routes/api_routes.dart';
import 'package:http/http.dart' as http;

class UserProfileController extends GetxController {
  var userProfile = UserProfileModel().obs;
  RxString selectedGender = ''.obs;

  Future<void> fetchUserProfile() async {
    try {
      EasyLoading.show();
      var uri = await Uri.parse(ApiRoutes.userProfile);
      var headers = {
        "Content-type": "application/json",
        "Authorization": 'Bearer ${MyConstant.access_token}'
      };

      print(uri.toString());

      var response = await http.get(uri, headers: headers);
      print(response.statusCode);
      print(response.body);

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        print("DATA ---------- $data");

        userProfile(UserProfileModel.fromJson(data));
        EasyLoading.dismiss();
      } else {
        EasyLoading.dismiss();
        throw Exception(
            'Failed to fetch profile. Status code: ${response.statusCode}');
      }
    } catch (e) {
      EasyLoading.dismiss();
      print(e);
    }
  }

  Future<void> editUserProfile(Map<String, dynamic> body, File? image) async {
  try {
    EasyLoading.show();

    String apiUrl = ApiRoutes.userUpdatedProfile;
    var headers = {
      "Authorization": 'Bearer ${MyConstant.access_token}'
    };

    var request = http.MultipartRequest('POST', Uri.parse(apiUrl));
    request.headers.addAll(headers);

    // Add text fields to the request
    body.forEach((key, value) {
      request.fields[key] = value.toString();
    });

    // Add image file to the request if available
    if (image != null) {
      request.files.add(await http.MultipartFile.fromPath('image', image.path));
    }

    var response = await http.Response.fromStream(await request.send());

    print("Response status code: ${response.statusCode}");
    print("Response body: ${response.body}");

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      var success = data["status"];
      if (!success) {
        throw Exception('Failed to save User Profile: ${data["message"]}');
      } else {
        print(data["message"]);
      }
      EasyLoading.dismiss();
    } else {
      EasyLoading.dismiss();
      throw Exception('Failed to send user Profile ${response.statusCode}');
    }
  } catch (e) {
    EasyLoading.dismiss();
    print('Error editing user profile: $e');
    throw e;
  }
}
}
