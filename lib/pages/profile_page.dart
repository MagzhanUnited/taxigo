import 'package:flutter/material.dart';
import 'package:flutter_taxi_go/controllers/user_controller.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});
  final UserController userController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar(),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(left: 120, top: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 200,
                    height: 200,
                    margin: EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                      border: Border.all(width: 1.5, color: Colors.black),
                      borderRadius: BorderRadius.circular(200),
                      // image: const DecorationImage(
                      //     image: AssetImage('images/ava.jpg'),
                      //     fit: BoxFit.cover)
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.person,
                        size: 80,
                      ),
                    ),
                  ),
                  Text(
                    userController.user.value!.username!,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Row(
                        children: [
                          Row(
                              children: List.generate(
                            5,
                            (index) =>
                                const Icon(Icons.star, color: Colors.grey),
                          )),
                          Text('(0 отзывов)')
                        ],
                      )),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              width: double.maxFinite,
              height: 1.5,
              color: Colors.grey[400],
            ),
            Container(
              margin: const EdgeInsets.only(left: 10, top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Телефон',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(userController.user.value!.number!),
                  const SizedBox(height: 20),
                  const Text(
                    'Статистика заказов',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  SfCartesianChart(
                      // title: ChartTitle(text: 'Half yearly sales analysis'),
                      // Enable legend
                      // legend: Legend(isVisible: true),
                      // Enable tooltip
                      // tooltipBehavior: TooltipBehavior(enable: true),
                      primaryXAxis: CategoryAxis(),
                      series: <LineSeries<SalesData, String>>[
                        LineSeries<SalesData, String>(
                            // Bind data source
                            dataSource: <SalesData>[
                              SalesData('Jan', 5),
                              SalesData('Feb', 28),
                              SalesData('Mar', 34),
                              SalesData('Apr', 32),
                              SalesData('May', 40)
                            ],
                            dataLabelSettings:
                                DataLabelSettings(isVisible: true),
                            xValueMapper: (SalesData sales, _) => sales.year,
                            yValueMapper: (SalesData sales, _) => sales.sales)
                      ])
                ],
              ),
            ),
            Container(
                margin: EdgeInsets.only(left: 25, top: 20),
                child: GestureDetector(
                  child: Row(
                    children: const [
                      Icon(Icons.exit_to_app),
                      Text(
                        'Выход',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  onTap: () {
                    userController.user.value = null;
                    Get.toNamed('/');
                  },
                ))
          ],
        ));
  }

  AppBar appBar() {
    return AppBar(
      title: const Text('Личный кабинет'),
    );
  }
}

class SalesData {
  SalesData(this.year, this.sales);
  final String year;
  final double sales;
}
