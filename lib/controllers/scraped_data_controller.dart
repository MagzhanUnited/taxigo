import 'package:flutter_taxi_go/models/scraped_data_module.dart';
import 'package:flutter_taxi_go/services/remote_service.dart';
import 'package:get/get.dart';

class ScrapedDataController extends GetxController {
  RxList<ScrapedData> data = <ScrapedData>[].obs;

  Future<void> fetchData() async {
    var response = await RemoteService.scrapeData();
    print('fetch data');
    if (response != null) {
      data.value = response;
      return;
    }
    print('Remote service failed on scraping data');
  }
}
