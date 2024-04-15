import 'dart:convert';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../models/categories_model.dart';
import '../routes/api_routes.dart';

class CategoriesController extends GetxController {


  RxList<CategoriesData> categoryDataList = <CategoriesData>[].obs;

  Future<void> categoriesFetch() async {
     try {
      EasyLoading.show();
      var uri = await Uri.parse(ApiRoutes.categoriesFetch);
    
      print(uri.toString());

      var response = await http.get(uri, );
      print(response.statusCode);
      print(response.body);

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        print("DATA ---------- $data");
        
         CategoriesModel categoryModel = categoriesModelFromJson(json.encode(data));

        categoryDataList.assignAll(categoryModel.data ?? []);
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

