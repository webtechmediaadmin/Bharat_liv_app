// To parse this JSON data, do
//
//     final userProfileModelCategory = userProfileModelCategoryFromJson(jsonString);

import 'dart:convert';

UserProfileModelCategory userProfileModelCategoryFromJson(String str) => UserProfileModelCategory.fromJson(json.decode(str));

String userProfileModelCategoryToJson(UserProfileModelCategory data) => json.encode(data.toJson());

class UserProfileModelCategory {
    bool? status;
    int? count;
    String? message;
    Data? data;

    UserProfileModelCategory({
        this.status,
        this.count,
        this.message,
        this.data,
    });

    factory UserProfileModelCategory.fromJson(Map<String, dynamic> json) => UserProfileModelCategory(
        status: json["status"],
        count: json["count"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "count": count,
        "message": message,
        "data": data?.toJson(),
    };
}

class Data {
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
    String? bio;
    dynamic userToken;
    bool? paidMember;
    String? memberCategory;
    int? totalWatchTime;
    dynamic subscriptionDate;
    dynamic expiryDate;
    DateTime? createdAt;
    DateTime? updatedAt;

    Data({
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
        this.bio,
        this.userToken,
        this.paidMember,
        this.memberCategory,
        this.totalWatchTime,
        this.subscriptionDate,
        this.expiryDate,
        this.createdAt,
        this.updatedAt,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
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
        bio: json["bio"],
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
        "bio": bio,
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
