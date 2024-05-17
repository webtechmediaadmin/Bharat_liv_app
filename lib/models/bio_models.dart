// To parse this JSON data, do
//
//     final bioModel = bioModelFromJson(jsonString);

import 'dart:convert';

BioModel bioModelFromJson(String str) => BioModel.fromJson(json.decode(str));

String bioModelToJson(BioModel data) => json.encode(data.toJson());

class BioModel {
    bool? status;
    int? count;
    List<BioData>? data;
    String? message;

    BioModel({
        this.status,
        this.count,
        this.data,
        this.message,
    });

    factory BioModel.fromJson(Map<String, dynamic> json) => BioModel(
        status: json["status"],
        count: json["count"],
        data: json["data"] == null ? [] : List<BioData>.from(json["data"]!.map((x) => BioData.fromJson(x))),
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "count": count,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "message": message,
    };
}

class BioData {
    int? id;
    int? userId;
    int? categoryId;
    String? title;
    String? thumbNail;
    String? video;
    bool? status;
    String? rating;
    int? count;
    DateTime? createdAt;
    DateTime? updatedAt;
    User? user;
    Category? category;
    List<Like>? likes;
    List<Comment>? comments;

    BioData({
        this.id,
        this.userId,
        this.categoryId,
        this.title,
        this.thumbNail,
        this.video,
        this.status,
        this.rating,
        this.count,
        this.createdAt,
        this.updatedAt,
        this.user,
        this.category,
        this.likes,
        this.comments,
    });

    factory BioData.fromJson(Map<String, dynamic> json) => BioData(
        id: json["id"],
        userId: json["userID"],
        categoryId: json["categoryID"],
        title: json["title"],
        thumbNail: json["thumbNail"],
        video: json["video"],
        status: json["status"],
        rating: json["rating"],
        count: json["count"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        category: json["category"] == null ? null : Category.fromJson(json["category"]),
        likes: json["likes"] == null ? [] : List<Like>.from(json["likes"]!.map((x) => Like.fromJson(x))),
        comments: json["comments"] == null ? [] : List<Comment>.from(json["comments"]!.map((x) => Comment.fromJson(x))),
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
        "count": count,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "user": user?.toJson(),
        "category": category?.toJson(),
        "likes": likes == null ? [] : List<dynamic>.from(likes!.map((x) => x.toJson())),
        "comments": comments == null ? [] : List<dynamic>.from(comments!.map((x) => x.toJson())),
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

class Comment {
    int? id;
    int? userId;
    int? contentId;
    String? text;
    DateTime? createdAt;
    DateTime? updatedAt;
    User? user;

    Comment({
        this.id,
        this.userId,
        this.contentId,
        this.text,
        this.createdAt,
        this.updatedAt,
        this.user,
    });

    factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        id: json["id"],
        userId: json["userID"],
        contentId: json["contentID"],
        text: json["text"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        user: json["user"] == null ? null : User.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "userID": userId,
        "contentID": contentId,
        "text": text,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "user": user?.toJson(),
    };
}

class User {
    int? id;
    String? name;
    String? email;
    dynamic emailOtp;
    bool? isEmailVerified;
    String? password;
    String? phoneNumber;
    String? phoneNumberOtp;
    bool? isNumberVerified;
    String? gender;
    String? role;
    String? image;
    String? bio;
    dynamic userToken;
    bool? paidMember;
    String? memberCategory;
    int? totalWatchTime;
    dynamic subscriptionDate;
    dynamic expiryDate;
    dynamic referenceSpeakerName;
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
        this.bio,
        this.userToken,
        this.paidMember,
        this.memberCategory,
        this.totalWatchTime,
        this.subscriptionDate,
        this.expiryDate,
        this.referenceSpeakerName,
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
        bio: json["bio"],
        userToken: json["userToken"],
        paidMember: json["paidMember"],
        memberCategory: json["memberCategory"],
        totalWatchTime: json["totalWatchTime"],
        subscriptionDate: json["subscriptionDate"],
        expiryDate: json["expiryDate"],
        referenceSpeakerName: json["referenceSpeakerName"],
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
        "referenceSpeakerName": referenceSpeakerName,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
    };
}

class Like {
    int? id;
    int? userId;
    int? contentId;
    DateTime? createdAt;
    DateTime? updatedAt;

    Like({
        this.id,
        this.userId,
        this.contentId,
        this.createdAt,
        this.updatedAt,
    });

    factory Like.fromJson(Map<String, dynamic> json) => Like(
        id: json["id"],
        userId: json["userID"],
        contentId: json["contentID"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "userID": userId,
        "contentID": contentId,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
    };
}
