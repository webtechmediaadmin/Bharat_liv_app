import 'dart:convert';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../constant/constant.dart';
import '../models/speakers_model.dart';
import '../routes/api_routes.dart';

class SpeakersController extends GetxController {

  RxList<SpeakersData> speakerDataList = <SpeakersData>[].obs;

  Future<void> speakersFetch() async {
     try {
      EasyLoading.show();
      var uri = await Uri.parse(ApiRoutes.speakersFetch);
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
        
         SpeakersModel speakersModel = speakersModelFromJson(json.encode(data));

        speakerDataList.assignAll(speakersModel.data ?? []);
        EasyLoading.dismiss();
      } else {
        EasyLoading.dismiss();
        throw Exception(
            'Failed to fetch categories. Status code: ${response.statusCode}');
      }
    } catch (e) {
      EasyLoading.dismiss();
      print(e);
    }

  }


}