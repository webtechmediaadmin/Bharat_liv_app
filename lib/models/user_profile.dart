// To parse this JSON data, do
//
//     final userProfileModel = userProfileModelFromJson(jsonString);

import 'dart:convert';

UserProfileModel userProfileModelFromJson(String str) => UserProfileModel.fromJson(json.decode(str));

String userProfileModelToJson(UserProfileModel data) => json.encode(data.toJson());

class UserProfileModel {
    bool? status;
    String? message;
    UserProfileData? data;

    UserProfileModel({
        this.status,
        this.message,
        this.data,
    });

    factory UserProfileModel.fromJson(Map<String, dynamic> json) => UserProfileModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : UserProfileData.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
    };
}

class UserProfileData {
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

    UserProfileData({
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

    factory UserProfileData.fromJson(Map<String, dynamic> json) => UserProfileData(
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
