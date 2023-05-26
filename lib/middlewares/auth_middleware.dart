// import 'package:flutter/material.dart';
// import 'package:flutter_taxi_go/controllers/user_controller.dart';
// import 'package:get/get.dart';

// class AuthMiddleware extends GetMiddleware {
//   final UserController userController = Get.find();
//   @override
//   RouteSettings? redirect(String? route) {
//     // Add your logic to determine if the user is authenticated
//     // If not authenticated, return the route to redirect to, otherwise return null.
//     // Example: if (!user.isAuthenticated) return RouteSettings(name: '/login');
//     if (userController.user.value == null) {
//       Get.snackbar('Ресестрация', 'войдите или зарегистрируйтесь');
//       return const RouteSettings(name: '/register');
//     }

//     return null;
//   }
// }
