// To parse this JSON data, do
//
//     final orderList = orderListFromJson(jsonString);

import 'dart:convert';

List<OrderList> ordersListFromJson(String str) =>
    List<OrderList>.from(json.decode(str).map((x) => OrderList.fromJson(x)));

String ordersListToJson(List<OrderList> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

OrderList orderListFromJson(String str) => OrderList.fromJson(json.decode(str));

String orderListToJson(OrderList data) => json.encode(data.toJson());

class OrderList {
  int? id;
  String place;
  String number;
  List<Order> orders;

  OrderList({
    this.id,
    required this.place,
    required this.number,
    required this.orders,
  });

  factory OrderList.fromJson(Map<String, dynamic> json) => OrderList(
        id: json["id"],
        place: json["place"],
        number: json["number"],
        orders: List<Order>.from(json["orders"].map((x) => Order.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "place": place,
        "number": number,
        "orders": List<dynamic>.from(orders.map((x) => x.toJson())),
      };
}

class Order {
  int? id;
  String name;
  String amount;
  String price;
  int? orderListId;

  Order({
    this.id,
    required this.name,
    required this.amount,
    required this.price,
    this.orderListId,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json["id"],
        name: json["name"],
        amount: json["amount"],
        price: json["price"],
        orderListId: json["orderListID"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "amount": amount,
        "price": price,
        "orderListID": orderListId,
      };
}
