import 'package:flutter_taxi_go/controllers/order_conrtoller.dart';
import 'package:flutter_taxi_go/models/book_data_module.dart';
import 'package:flutter_taxi_go/models/order_list_module.dart';
import 'package:flutter_taxi_go/services/remote_service.dart';
import 'package:get/get.dart';

class BooksController extends GetxController {
  Rxn<List<BookData>> bookController = Rxn<List<BookData>>();
  Rxn<List<OrderList>> ordersController = Rxn<List<OrderList>>();
  Rxn<List<OrderList>> orderController = Rxn<List<OrderList>>();
  @override
  onReady() {
    fetchData();
    fetchOrders();
    super.onReady();
  }

  Future<void> fetchData() async {
    var response = await RemoteService.getBooks();
    if (response != null) {
      bookController.value = response;
    }
  }

  Future<void> fetchOrders() async {
    var response = await RemoteService.getOrders();
    if (response != null) {
      ordersController.value = response;
    } else {
      print("ERROR fetchOrders");
    }
  }

  Future<void> fetchOrder(String number) async {
    var response = await RemoteService.getOrder(number);
    if (response != null) {
      orderController.value = response;
    } else {
      print("ERROR fetchOrder");
    }
  }
}
