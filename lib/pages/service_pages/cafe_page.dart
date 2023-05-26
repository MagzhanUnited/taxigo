import 'package:flutter/material.dart';
import 'package:flutter_taxi_go/controllers/scraped_data_controller.dart';
import 'package:get/get.dart';

class CafePage extends StatelessWidget {
  final ScrapedDataController snapshot = Get.find();
  CafePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Кафе Астана'),
          leading: IconButton(
              onPressed: () => Get.back(),
              icon: const Icon(Icons.arrow_back_ios)),
        ),
        body: Obx(() {
          if (snapshot.data.isEmpty) {
            print('not hasData');
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
              ),
            );
          }
          return SingleChildScrollView(
              child: Column(
                  children: List.generate(
                      snapshot.data.length,
                      (index) => GestureDetector(
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            width: double.maxFinite,
                            height: 240,
                            decoration: BoxDecoration(
                                color: Color.fromARGB(71, 238, 195, 66),
                                borderRadius: BorderRadius.circular(30)),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(
                                          left: 10, top: 20),
                                      width: 200,
                                      height: 200,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                  snapshot.data[index].image),
                                              fit: BoxFit.cover)),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            softWrap: false,
                                            snapshot.data[index].name,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          underTitle(
                                              snapshot.data[index].description),
                                          underTitle(
                                              snapshot.data.value[index].style),
                                          underTitle(
                                              snapshot.data.value[index].price)
                                        ],
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                          onTap: () => Get.toNamed(
                                '/cafes/inner',
                                arguments: {
                                  "id": int.parse(snapshot.data[index].id),
                                  "name": snapshot.data[index].name
                                },
                              )))));
        }));
  }

  Widget underTitle(String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            softWrap: false,
            text,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}
