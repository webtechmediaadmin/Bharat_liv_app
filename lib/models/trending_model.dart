// To parse this JSON data, do
//
//     final trendingModel = trendingModelFromJson(jsonString);

import 'dart:convert';

TrendingModel trendingModelFromJson(String str) => TrendingModel.fromJson(json.decode(str));

String trendingModelToJson(TrendingModel data) => json.encode(data.toJson());

class TrendingModel {
    bool? status;
    int? count;
    List<TrendingData>? data;
    String? message;

    TrendingModel({
        this.status,
        this.count,
        this.data,
        this.message,
    });

    factory TrendingModel.fromJson(Map<String, dynamic> json) => TrendingModel(
        status: json["status"],
        count: json["count"],
        data: json["data"] == null ? [] : List<TrendingData>.from(json["data"]!.map((x) => TrendingData.fromJson(x))),
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "count": count,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "message": message,
    };
}

class TrendingData {
    int? id;
    int? userId;
    int? categoryId;
    String? title;
    String? thumbNail;
    String? video;
    bool? status;
    String? rating;
    bool? hasApprovedByAdmin;
    int? count;
    DateTime? createdAt;
    DateTime? updatedAt;
    User? user;
    Category? category;

    TrendingData({
        this.id,
        this.userId,
        this.categoryId,
        this.title,
        this.thumbNail,
        this.video,
        this.status,
        this.rating,
        this.hasApprovedByAdmin,
        this.count,
        this.createdAt,
        this.updatedAt,
        this.user,
        this.category,
    });

    factory TrendingData.fromJson(Map<String, dynamic> json) => TrendingData(
        id: json["id"],
        userId: json["userID"],
        categoryId: json["categoryID"],
        title: json["title"],
        thumbNail: json["thumbNail"],
        video: json["video"],
        status: json["status"],
        rating: json["rating"],
        hasApprovedByAdmin: json["hasApprovedByAdmin"],
        count: json["count"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        category: json["category"] == null ? null : Category.fromJson(json["category"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "userID": userId,
        "categoryID": categoryId,
        "title": title,
        "thumbNail": thumbNail,
        "video": video,
        "status": status,
        "rating": rating,
        "hasApprovedByAdmin": hasApprovedByAdmin,
        "count": count,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "user": user?.toJson(),
        "category": category?.toJson(),
    };
}

class Category {
    int? id;
    String? title;
    int? totalVideos;
    bool? status;
    DateTime? createdAt;
    DateTime? updatedAt;

    Category({
        this.id,
        this.title,
        this.totalVideos,
        this.status,
        this.createdAt,
        this.updatedAt,
    });

    factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        title: json["title"],
        totalVideos: json["totalVideos"],
        status: json["status"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "totalVideos": totalVideos,
        "status": status,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
    };
}

class User {
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

    User({
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

    factory User.fromJson(Map<String, dynamic> json) => User(
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
