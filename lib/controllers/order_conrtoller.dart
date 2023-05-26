import 'package:flutter_taxi_go/models/book_food_data_module.dart';
import 'package:get/get.dart';

class Orders {
  String name;
  int amount;
  int price;
  String place;
  Orders(
      {required this.name,
      required this.amount,
      required this.place,
      required this.price});
}

class OrderController extends GetxController {
  RxList<Orders> order = <Orders>[].obs;
}
