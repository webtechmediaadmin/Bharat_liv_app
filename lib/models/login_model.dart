// To parse this JSON data, do
//
//     final loginPhoneModel = loginPhoneModelFromJson(jsonString);

import 'dart:convert';

LoginPhoneModel loginPhoneModelFromJson(String str) => LoginPhoneModel.fromJson(json.decode(str));

String loginPhoneModelToJson(LoginPhoneModel data) => json.encode(data.toJson());

class LoginPhoneModel {
    bool? status;
    String? message;
    String? otp;

    LoginPhoneModel({
        this.status,
        this.message,
        this.otp,
    });

    factory LoginPhoneModel.fromJson(Map<String, dynamic> json) => LoginPhoneModel(
        status: json["status"],
        message: json["message"],
        otp: json["otp"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "otp": otp,
    };
}
