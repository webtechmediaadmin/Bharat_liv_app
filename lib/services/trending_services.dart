import 'dart:convert';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../models/trending_model.dart';
import '../routes/api_routes.dart';

class TrendingController extends GetxController {

  RxList<TrendingData> trendingDataList = <TrendingData>[].obs;

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
        
         TrendingModel trendingModel = trendingModelFromJson(json.encode(data));

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