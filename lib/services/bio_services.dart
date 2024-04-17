import 'dart:convert';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../constant/constant.dart';
import '../models/bio_models.dart';
import '../models/user_profile1.dart';
import '../routes/api_routes.dart';

class BioController extends GetxController {
 var userProfileCategoryModel = UserProfileModelCategory().obs; 

  Future<void> userProfileCategoryFetch(String id) async {
    try {
      EasyLoading.show();
      var uri = await Uri.parse(ApiRoutes.bioApi1 + id);
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
        print("DATA1 ---------- $data");

        userProfileCategoryModel(UserProfileModelCategory.fromJson(data));
        EasyLoading.dismiss();
      } else {
        EasyLoading.dismiss();
        throw Exception(
            'Failed to bioProfile1. Status code: ${response.statusCode}');
      }
    } catch (e) {
      EasyLoading.dismiss();
      print(e);
    }
  }



  var bioModel = BioModel().obs;
 
  Future<void> bioFetchData(String id) async {
    try {
      EasyLoading.show();
      var uri = await Uri.parse(ApiRoutes.bioApi + id);
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

        bioModel(BioModel.fromJson(data));
        EasyLoading.dismiss();
      } else {
        EasyLoading.dismiss();
        throw Exception(
            'Failed to bioProfile. Status code: ${response.statusCode}');
      }
    } catch (e) {
      EasyLoading.dismiss();
      print(e);
    }
  }
}