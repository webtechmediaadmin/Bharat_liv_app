import 'dart:convert';

import 'package:http/http.dart' as http;

import '../constant/constant.dart';
import '../models/login_model.dart';
import '../models/response_model.dart';
import '../models/verify_otp_model.dart';
import '../routes/api_routes.dart';

class LoginServicesPhone {


  Future<ResponseModel> loginUser(String phone) async {
    var uri = Uri.parse(ApiRoutes.userLogin);
    var headers = {"Content-type": "application/json"};
    final requestBody = {'phoneNumber': phone};
    print(uri.toString());
    print(requestBody.toString());
    try {
      var response = await http.post(uri, headers: headers, body: jsonEncode(requestBody));
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200 || response.statusCode == 400) {
        var loginModel = LoginPhoneModel.fromJson(jsonDecode(response.body));
        if (loginModel.status == true) {
          Map<String, dynamic> jsonFinal = {
            DATA_KEY: loginModel,
            STATUS_KEY: true,
            ERROR_KEY: ""
          };
          return ResponseModel.fromJson(jsonFinal);
        } else {
          Map<String, dynamic> jsonFinal = {
            DATA_KEY: null,
            STATUS_KEY: false,
            ERROR_KEY: loginModel.message
          };
          return ResponseModel.fromJson(jsonFinal);
        }
      } else {
        var loginModel = LoginPhoneModel.fromJson(json.decode(response.body));

        Map<String, dynamic> jsonFinal = {
          DATA_KEY: null,
          STATUS_KEY: false,
          ERROR_KEY: loginModel.message
        };
        return ResponseModel.fromJson(jsonFinal);
      }
    } catch (ex) {
      rethrow;
    }
  }

  Future<ResponseModel> verifyOtp(String otp, String phoneNumber) async {
    var uri = Uri.parse(ApiRoutes.verifyOTPApi1);
    print(uri.toString());
    var headers = {"Content-type": "application/json"};
    final  requestBody = {"phoneNumberOTP": otp, "phoneNumber": phoneNumber};
    print(requestBody);

    try {
      var response =
          await http.post(uri, headers: headers, body: jsonEncode(requestBody));
      print("status code ${response.statusCode}");
      print("response body ${response.body}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        var dataModel = VerifyOtpModel.fromJson(data);
        if (dataModel.status == true) {
          Map<String, dynamic> jsonFinal = {
            DATA_KEY: dataModel,
            STATUS_KEY: true,
            ERROR_KEY: ""
          };
          return ResponseModel.fromJson(jsonFinal);
        } else {
          Map<String, dynamic> jsonFinal = {
            DATA_KEY: null,
            STATUS_KEY: false,
            ERROR_KEY: dataModel.message
          };
          return ResponseModel.fromJson(jsonFinal);
        }
      } else {
        var dataModel = VerifyOtpModel.fromJson(json.decode(response.body));
        print("errorororo  ${dataModel.message}");
        Map<String, dynamic> jsonFinal = {
          DATA_KEY: null,
          STATUS_KEY: false,
          ERROR_KEY: dataModel.message
        };
        return ResponseModel.fromJson(jsonFinal);
      }
    } catch (e) {
      Map<String, dynamic> jsonFinal = {
        DATA_KEY: null,
        STATUS_KEY: false,
        ERROR_KEY: e
      };
      return ResponseModel.fromJson(jsonFinal);
    }
  }

  
}
