// To parse this JSON data, do
//
//     final bookData = bookDataFromJson(jsonString);

import 'dart:convert';

BookData bookDataFromJson(String str) => BookData.fromJson(json.decode(str));

String bookDataToJson(BookData data) => json.encode(data.toJson());

List<BookData> booksDataFromJson(String str) =>
    List<BookData>.from(json.decode(str).map((x) => BookData.fromJson(x)));

String booksDataToJson(List<BookData> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

// To parse this JSON data, do
//
//     final bookData = bookDataFromJson(jsonString);

class BookData {
  int? id;
  String amount;
  String special;
  String date;
  String time;
  String person;
  String number;
  String? accepted;
  String place;

  BookData({
    this.id,
    required this.amount,
    required this.special,
    required this.date,
    required this.time,
    required this.person,
    required this.number,
    this.accepted,
    required this.place,
  });

  factory BookData.fromJson(Map<String, dynamic> json) => BookData(
        id: json["id"],
        amount: json["amount"],
        special: json["special"],
        date: json["date"],
        time: json["time"],
        person: json["person"],
        number: json["number"],
        accepted: json["accepted"],
        place: json["place"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "amount": amount,
        "special": special,
        "date": date,
        "time": time,
        "person": person,
        "number": number,
        "accepted": accepted,
        "place": place,
      };
}
