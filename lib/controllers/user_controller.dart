import 'package:get/get.dart';

class User {
  String? username;
  String? password;
  String? number;
  String? status;
  String? token;
  User(
      {this.username,
      this.password,
      this.number,
      this.status = 'Қолданушы',
      this.token});
}

class UserController extends GetxController {
  final user = Rxn<User>();
}
