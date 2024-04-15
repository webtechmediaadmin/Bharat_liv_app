// To parse this JSON data, do
//
//     final speakersModel = speakersModelFromJson(jsonString);

import 'dart:convert';

SpeakersModel speakersModelFromJson(String str) => SpeakersModel.fromJson(json.decode(str));

String speakersModelToJson(SpeakersModel data) => json.encode(data.toJson());

class SpeakersModel {
    bool? status;
    int? count;
    String? message;
    List<SpeakersData>? data;

    SpeakersModel({
        this.status,
        this.count,
        this.message,
        this.data,
    });

    factory SpeakersModel.fromJson(Map<String, dynamic> json) => SpeakersModel(
        status: json["status"],
        count: json["count"],
        message: json["message"],
        data: json["data"] == null ? [] : List<SpeakersData>.from(json["data"]!.map((x) => SpeakersData.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "count": count,
        "message": message,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class SpeakersData {
    int? id;
    String? name;
    String? email;
    dynamic emailOtp;
    bool? isEmailVerified;
    String? password;
    dynamic phoneNumber;
    dynamic phoneNumberOtp;
    bool? isNumberVerified;
    dynamic gender;
    String? role;
    String? image;
    dynamic userToken;
    bool? paidMember;
    String? memberCategory;
    int? totalWatchTime;
    dynamic subscriptionDate;
    dynamic expiryDate;
    DateTime? createdAt;
    DateTime? updatedAt;

    SpeakersData({
        this.id,
        this.name,
        this.email,
        this.emailOtp,
        this.isEmailVerified,
        this.password,
        this.phoneNumber,
        this.phoneNumberOtp,
        this.isNumberVerified,
        this.gender,
        this.role,
        this.image,
        this.userToken,
        this.paidMember,
        this.memberCategory,
        this.totalWatchTime,
        this.subscriptionDate,
        this.expiryDate,
        this.createdAt,
        this.updatedAt,
    });

    factory SpeakersData.fromJson(Map<String, dynamic> json) => SpeakersData(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        emailOtp: json["emailOTP"],
        isEmailVerified: json["isEmailVerified"],
        password: json["password"],
        phoneNumber: json["phoneNumber"],
        phoneNumberOtp: json["phoneNumberOTP"],
        isNumberVerified: json["isNumberVerified"],
        gender: json["gender"],
        role: json["role"],
        image: json["image"],
        userToken: json["userToken"],
        paidMember: json["paidMember"],
        memberCategory: json["memberCategory"],
        totalWatchTime: json["totalWatchTime"],
        subscriptionDate: json["subscriptionDate"],
        expiryDate: json["expiryDate"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "emailOTP": emailOtp,
        "isEmailVerified": isEmailVerified,
        "password": password,
        "phoneNumber": phoneNumber,
        "phoneNumberOTP": phoneNumberOtp,
        "isNumberVerified": isNumberVerified,
        "gender": gender,
        "role": role,
        "image": image,
        "userToken": userToken,
        "paidMember": paidMember,
        "memberCategory": memberCategory,
        "totalWatchTime": totalWatchTime,
        "subscriptionDate": subscriptionDate,
        "expiryDate": expiryDate,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
    };
}
