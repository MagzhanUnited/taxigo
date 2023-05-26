// To parse this JSON data, do
//
//     final scrapedData = scrapedDataFromJson(jsonString);

import 'dart:convert';

List<String> menuDataFromJson(String str) =>
    List<String>.from(json.decode(str).map((x) => x));

String menuDataToJson(List<String> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x)));

// To parse this JSON data, do
//
//     final scrapedData = scrapedDataFromJson(jsonString);

List<ScrapedData> scrapedDataFromJson(String str) => List<ScrapedData>.from(
    json.decode(str).map((x) => ScrapedData.fromJson(x)));

String scrapedDataToJson(List<ScrapedData> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ScrapedData {
  String image;
  String name;
  String price;
  String style;
  String description;
  String id;

  ScrapedData({
    required this.image,
    required this.name,
    required this.price,
    required this.style,
    required this.description,
    required this.id,
  });

  factory ScrapedData.fromJson(Map<String, dynamic> json) => ScrapedData(
        image: json["image"],
        name: json["name"],
        price: json["price"],
        style: json["style"],
        description: json["description"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "image": image,
        "name": name,
        "price": price,
        "style": style,
        "description": description,
        "id": id,
      };
}
