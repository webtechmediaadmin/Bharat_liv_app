import 'dart:convert';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../models/bio_models.dart';
import '../routes/api_routes.dart';

class TrendingController extends GetxController {

  RxList<BioData> trendingDataList = <BioData>[].obs;
  Future<void> trendingFetch(String apiUrl, {bool isBanner = false}) async {
     try {
      EasyLoading.show();
      var uri = await Uri.parse(apiUrl);
    
      print(uri.toString());

      var response = await http.get(uri, );
      print(response.statusCode);
      print(response.body);

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        print("DATA ---------- $data");
        
         BioModel trendingModel = bioModelFromJson(json.encode(data));

        trendingDataList.assignAll(trendingModel.data ?? []);
        EasyLoading.dismiss();
      } else {
        EasyLoading.dismiss();
        throw Exception(
            'Failed to fetch trendingModel. Status code: ${response.statusCode}');
      }
    } catch (e) {
      EasyLoading.dismiss();
      print(e);
    }

  }


  



}