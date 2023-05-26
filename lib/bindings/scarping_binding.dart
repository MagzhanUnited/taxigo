import 'package:flutter_taxi_go/controllers/scraped_data_controller.dart';
import 'package:get/get.dart';

class ScarpingBinding implements Bindings {
  var data = Get.put(ScrapedDataController());
  @override
  void dependencies() {
    print('binding data');
    // TODO: implement dependencies
    data.fetchData();
  }
}
