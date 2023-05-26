// To parse this JSON data, do
//
//     final innerData = innerDataFromJson(jsonString);

import 'dart:convert';

InnerData innerDataFromJson(String str) => InnerData.fromJson(json.decode(str));

String innerDataToJson(InnerData data) => json.encode(data.toJson());

class InnerData {
  List<String> images;
  String adress;
  String text;
  String number;

  InnerData({
    required this.images,
    required this.adress,
    required this.text,
    required this.number,
  });

  factory InnerData.fromJson(Map<String, dynamic> json) => InnerData(
        images: List<String>.from(json["images"].map((x) => x)),
        adress: json["adress"],
        text: json["text"],
        number: json["number"],
      );

  Map<String, dynamic> toJson() => {
        "images": List<dynamic>.from(images.map((x) => x)),
        "adress": adress,
        "text": text,
        "number": number,
      };
}
