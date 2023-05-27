import 'package:flutter/material.dart';
import 'package:flutter_taxi_go/controllers/books_controller.dart';
import 'package:flutter_taxi_go/controllers/user_controller.dart';
import 'package:flutter_taxi_go/login_pages/components/my_button.dart';
import 'package:flutter_taxi_go/models/book_data_module.dart';
import 'package:flutter_taxi_go/models/order_list_module.dart';
import 'package:flutter_taxi_go/services/remote_service.dart';
import 'package:get/get.dart';

class HistoryOrdersPage extends StatelessWidget {
  final UserController userController = Get.find();
  BooksController booksController = Get.find();
  HistoryOrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Тапсырыстар тарихы'),
      ),
      body: FutureBuilder(
          future: RemoteService.getBook(userController.user.value!.number!),
          builder: (context, snapshot) {
            booksController.fetchOrder(userController.user.value!.number!);
            if (!snapshot.hasData ||
                booksController.orderController.value == null) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.data!.isEmpty &&
                booksController.orderController.value!.isEmpty) {
              return Center(
                child: Text(
                  'Сізде әлі тапсырыс жоқ',
                  style: TextStyle(color: Colors.grey[600]!),
                ),
              );
            }
            return SafeArea(
                child: SingleChildScrollView(
              child: Column(
                children: [
                  Column(
                    children: List.generate(
                        snapshot.data!.length,
                        (index) => vacancieContainer(
                            snapshot.data![index].place,
                            snapshot.data![index].date +
                                " " +
                                snapshot.data![index].time,
                            snapshot.data![index].person,
                            snapshot.data![index].number,
                            snapshot.data![index].special,
                            snapshot.data![index].accepted!)),
                  ),
                  Column(
                      children: List.generate(
                    booksController.orderController.value!.length,
                    (index) => vacancieContainer2(
                        booksController.orderController.value![index].place!,
                        booksController.orderController.value![index].number!,
                        "Тағам жалдау",
                        "Жаплы бағасы: " +
                            count_money(
                                booksController.orderController.value![index]),
                        ordersList(
                            booksController.orderController.value![index]),
                        null,
                        null),
                  ))
                ],
              ),
            ));
          }),
    );
  }

  Widget vacancieContainer2(String title, String money, String company,
      String city, String text, String? status, BookData? data) {
    return Container(
      padding: const EdgeInsets.only(top: 15, left: 10),
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      width: double.maxFinite,
      // height: 220,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            softWrap: false,
            title,
            style: const TextStyle(
                color: Colors.blue, fontSize: 17, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            money,
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 10),
          Text(company),
          Text(city),
          const SizedBox(height: 10),
          Text(
            // overflow: TextOverflow.ellipsis,
            text,
            maxLines: 100,
            // softWrap: false,
          ),
          SizedBox(height: 15),
          const SizedBox(height: 15),
        ],
      ),
    );
  }

  Widget vacancieContainer(String title, String money, String company,
      String city, String text, String status) {
    return Container(
      padding: const EdgeInsets.only(top: 15, left: 10),
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      width: double.maxFinite,
      // height: 220,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            softWrap: false,
            title,
            style: const TextStyle(
                color: Colors.blue, fontSize: 17, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            money,
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 10),
          Text(company),
          Text(city),
          const SizedBox(height: 10),
          Text(
            // overflow: TextOverflow.ellipsis,
            text,
            maxLines: 100,
            // softWrap: false,
          ),
          SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              MyButton(onTap: null, selected: true, text: status),
              const SizedBox(width: 10)
            ],
          ),
          const SizedBox(height: 15),
        ],
      ),
    );
  }

  String count_money(OrderList orders) {
    int result = 0;
    for (var i in orders.orders) {
      result += int.parse(i.amount) * int.parse(i.price);
    }
    return result.toString();
  }

  String ordersList(OrderList orders) {
    String result = '';
    for (var i in orders.orders) {
      result += i.name + ",саны: " + i.amount + ",бағасы: " + i.price + "\n";
    }
    return result;
  }
}
