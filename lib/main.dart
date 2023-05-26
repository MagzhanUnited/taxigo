import 'package:flutter/material.dart';
import 'package:flutter_taxi_go/bindings/initial_binding.dart';
import 'package:flutter_taxi_go/pages/main_page.dart';
import 'package:flutter_taxi_go/routes/app_routes.dart';
import 'package:get/route_manager.dart';

void main() {
  InitialBindings().dependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        builder: (context, child) => MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
            child: child!),
        initialBinding: InitialBindings(),
        defaultTransition: Transition.zoom,
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          textTheme: const TextTheme(
            bodyMedium: TextStyle(
              color: Colors.black,
            ),
          ),
          primarySwatch: Colors.yellow,
        ),
        getPages: AppRoutes.routes());
  }
}
