import 'package:flutter_taxi_go/bindings/scarping_binding.dart';
import 'package:flutter_taxi_go/login_pages/login_page.dart';
import 'package:flutter_taxi_go/login_pages/register_page.dart';
import 'package:flutter_taxi_go/pages/history_orders_page.dart';
import 'package:flutter_taxi_go/pages/main_page.dart';
import 'package:flutter_taxi_go/pages/profile_page.dart';
import 'package:flutter_taxi_go/pages/request_page.dart';
import 'package:flutter_taxi_go/pages/service_pages/cafe_page.dart';
import 'package:flutter_taxi_go/pages/service_pages/inner/inner_cafe_page.dart';
import 'package:get/route_manager.dart';

class AppRoutes {
  static List<GetPage> routes() => [
        GetPage(name: '/', page: () => MainPage()),
        GetPage(name: '/profile', page: () => ProfilePage()),
        GetPage(
          name: '/register',
          page: () => RegisterPage(),
        ),
        GetPage(
          name: '/login',
          page: () => LoginPage(),
        ),
        GetPage(name: '/history', page: () => HistoryOrdersPage()),
        GetPage(
            name: '/cafes', page: () => CafePage(), binding: ScarpingBinding()),
        GetPage(name: '/cafes/inner', page: () => InnerCafePage()),
        // GetPage(name: '/vacancies', page: () => VacanciesPage()),
        GetPage(name: '/request', page: () => RequestPage())
        // GetPage(
        //     name: '/cafes/inner/book',
        //     page: () => BookPage(),
        //     middlewares: [AuthMiddleware()])
      ];
}
