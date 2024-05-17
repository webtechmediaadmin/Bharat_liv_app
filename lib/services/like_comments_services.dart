import 'dart:convert';

import 'package:get/get.dart';

import '../constant/constant.dart';
import '../routes/api_routes.dart';
import 'package:http/http.dart' as http;

class LikeCommentController extends GetxController {
  var userHasLiked = false.obs;
  var likeCount = 0.obs; // Observable variable to track like status
  Future<void> fetchLike(String id) async {
    try {
      var uri = Uri.parse(ApiRoutes.likesApi + id);
      var headers = {
        "Content-type": "application/json",
        "Authorization": 'Bearer ${MyConstant.access_token}'
      };
      print(uri.toString());
      var response = await http.post(uri, headers: headers);
      print(response.statusCode);
      print(response.body);

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        print("DATA ---------- $data");
      
        
      } else {
        throw Exception(
            'Failed to fetch likes. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error  user likes: $e');
      throw e;
    }
  }

  Future<void> likeVideo(String id) async {
    // Implement the logic to like the video (e.g., sending a POST request)
    await fetchLike(id); // Assuming fetchLike likes the video
  }

  Future<void> unlikeVideo(String id) async {
    // Implement the logic to unlike the video (e.g., sending a DELETE request)
    await fetchLike(id); // Modify this method to unlike the video if needed
  }


  Future<void> fetchComment(String id, String comment) async {
    try {
      var uri = Uri.parse(ApiRoutes.commentApi + id);
      var headers = {
        "Content-Type": "application/json",
        "Authorization": 'Bearer ${MyConstant.access_token}'
      };
      Map<String, String> body = {
         "text": comment
      };
      print(uri.toString());
      var response = await http.post(uri, body:jsonEncode(body), headers: headers);
      print(response.statusCode);
      print(response.body);

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        print("DATA ---------- $data");
      
        
      } else {
        throw Exception(
            'Failed to fetch comments. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error  user comments: $e');
      throw e;
    }
  }


 
}
