// To parse this JSON data, do
//
//     final categoriesModel = categoriesModelFromJson(jsonString);

import 'dart:convert';

CategoriesModel categoriesModelFromJson(String str) => CategoriesModel.fromJson(json.decode(str));

String categoriesModelToJson(CategoriesModel data) => json.encode(data.toJson());

class CategoriesModel {
    bool? status;
    int? count;
    List<CategoriesData>? data;
    String? message;

    CategoriesModel({
        this.status,
        this.count,
        this.data,
        this.message,
    });

    factory CategoriesModel.fromJson(Map<String, dynamic> json) => CategoriesModel(
        status: json["status"],
        count: json["count"],
        data: json["data"] == null ? [] : List<CategoriesData>.from(json["data"]!.map((x) => CategoriesData.fromJson(x))),
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "count": count,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "message": message,
    };
}

class CategoriesData {
    int? id;
    String? title;
    int? totalVideos;
    bool? status;
    DateTime? createdAt;
    DateTime? updatedAt;

    CategoriesData({
        this.id,
        this.title,
        this.totalVideos,
        this.status,
        this.createdAt,
        this.updatedAt,
    });

    factory CategoriesData.fromJson(Map<String, dynamic> json) => CategoriesData(
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
