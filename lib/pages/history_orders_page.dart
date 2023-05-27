import 'package:flutter/material.dart';
import 'package:flutter_taxi_go/controllers/user_controller.dart';
import 'package:flutter_taxi_go/login_pages/components/my_button.dart';
import 'package:flutter_taxi_go/services/remote_service.dart';
import 'package:get/get.dart';

class HistoryOrdersPage extends StatelessWidget {
  final UserController userController = Get.find();
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
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.data!.isEmpty) {
              return Center(
                child: Text(
                  'Сізде әлі тапсырыс жоқ',
                  style: TextStyle(color: Colors.grey[600]!),
                ),
              );
            }
            return Column(
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
            );
          }),
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
}
