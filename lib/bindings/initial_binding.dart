import 'package:flutter_taxi_go/controllers/user_controller.dart';
import 'package:get/get.dart';

class InitialBindings implements Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(UserController());
  }
}
