// To parse this JSON data, do
//
//     final pdfModel = pdfModelFromJson(jsonString);

import 'dart:convert';

PdfModel pdfModelFromJson(String str) => PdfModel.fromJson(json.decode(str));

String pdfModelToJson(PdfModel data) => json.encode(data.toJson());

class PdfModel {
    bool? status;
    int? count;
    List<PdfModelData>? data;
    String? message;

    PdfModel({
        this.status,
        this.count,
        this.data,
        this.message,
    });

    factory PdfModel.fromJson(Map<String, dynamic> json) => PdfModel(
        status: json["status"],
        count: json["count"],
        data: json["data"] == null ? [] : List<PdfModelData>.from(json["data"]!.map((x) => PdfModelData.fromJson(x))),
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "count": count,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "message": message,
    };
}

class PdfModelData {
    int? id;
    String? title;
    bool? status;
    String? file;
    DateTime? createdAt;
    DateTime? updatedAt;

    PdfModelData({
        this.id,
        this.title,
        this.status,
        this.file,
        this.createdAt,
        this.updatedAt,
    });

    factory PdfModelData.fromJson(Map<String, dynamic> json) => PdfModelData(
        id: json["id"],
        title: json["title"],
        status: json["status"],
        file: json["file"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "status": status,
        "file": file,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
    };
}
