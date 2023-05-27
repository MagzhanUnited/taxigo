import 'package:flutter_taxi_go/models/book_food_data_module.dart';
import 'package:flutter_taxi_go/services/remote_service.dart';
import 'package:get/get.dart';

class Orders {
  String? name;
  int? amount;
  int? price;
  String? place;
  Orders({this.name, this.amount, this.place, this.price});
}

class OrderController extends GetxController {
  RxList<Orders> order = <Orders>[].obs;
  Rxn<List<BookFoodData>> book_foods = Rxn<List<BookFoodData>>();

  Future<void> fetchData({required String place}) async {
    var response = await RemoteService.getBookFood(BookFoodData(place: place));
    if (response != null) {
      book_foods.value = response;
    } else {
      print("ERROR in fetchData");
    }
  }
}
