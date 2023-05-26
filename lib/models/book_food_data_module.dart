// To parse this JSON data, do
//
//     final bookFoodData = bookFoodDataFromJson(jsonString);

import 'dart:convert';

List<BookFoodData> booksFoodDataFromJson(String str) => List<BookFoodData>.from(
    json.decode(str).map((x) => BookFoodData.fromJson(x)));

String booksFoodDataToJson(List<BookFoodData> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

BookFoodData bookFoodDataFromJson(String str) =>
    BookFoodData.fromJson(json.decode(str));

String bookFoodDataToJson(BookFoodData data) => json.encode(data.toJson());

class BookFoodData {
  String? name;
  String? price;
  String place;
  String? image;

  BookFoodData({
    this.name,
    this.price,
    required this.place,
    this.image,
  });

  factory BookFoodData.fromJson(Map<String, dynamic> json) => BookFoodData(
        name: json["name"],
        price: json["price"],
        place: json["place"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "price": price,
        "place": place,
        "image": image,
      };
}
