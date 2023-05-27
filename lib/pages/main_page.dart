import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_taxi_go/controllers/user_controller.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MainPage extends StatelessWidget {
  final RxInt height = 0.obs;
  final UserController userController = Get.find();
  //final ScrollController _scrollController = ScrollController();
  // double _previousScrollOffset = 0.0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  static const Marker _kGooglePlexMarker = Marker(
      markerId: MarkerId('_kGooglePlex'),
      infoWindow: InfoWindow(title: 'Home'),
      icon: BitmapDescriptor.defaultMarker,
      position: LatLng(51.1116715, 71.3994478));
  static final Marker _kPlexMarker = Marker(
      markerId: const MarkerId('_kPlexMarker'),
      infoWindow: const InfoWindow(title: 'Google plex'),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      position: const LatLng(51.1135317, 71.4024669));
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(51.1116715, 71.3994478),
    zoom: 14.4746,
  );

  static const CameraPosition _kLake = CameraPosition(
    bearing: 192.8334901395799,
    target: LatLng(51.1116715, 71.3994478),
    tilt: 59.440717697143555,
    zoom: 19.151926040649414,
  );
  static final Polyline _kPolyLine = Polyline(
      polylineId: const PolylineId('_kPolyLine'),
      points: [_kPlexMarker.position, _kGooglePlexMarker.position]);

  MainPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        drawer: drawer(),
        body: Stack(
          children: [
            map(),
            bottomsheet(context),
            topBar(),
          ],
        ));
  }

  Widget map() {
    return GoogleMap(
      mapType: MapType.normal,
      markers: {_kGooglePlexMarker},
      initialCameraPosition: _kGooglePlex,
      // polylines: {_kPolyLine},
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
      },
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }

  void openDrawer() {
    _scaffoldKey.currentState!.openDrawer();
  }

  Widget drawer() {
    return Drawer(
        child: Obx(
      () => ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: userController.user.value == null
              ? authDrawer()
              : userController.user.value!.status == 'Егесі'
                  ? ownerDrawer()
                  : loggedDrawer()),
    ));
  }

  Widget topBar() {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 60, left: 20),
          child: Row(
            children: [
              IconButton(
                onPressed: openDrawer,
                icon: const Icon(
                  Icons.menu,
                  size: 30,
                ),
              ),
              const SizedBox(
                width: 130,
              ),
              const Text(
                'Astana',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              )
            ],
          ),
        )
      ],
    );
  }

  Widget listForDrawer(String text, IconData icon, String path) {
    return ListTile(
      title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text(text), Icon(icon)]),
      onTap: () {
        Get.toNamed(path);
      },
    );
  }

  Widget drawerHeader() {
    print(userController.user.value!.status!);
    return DrawerHeader(
        decoration: const BoxDecoration(
          color: Colors.blue,
        ),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1.5, color: Colors.black),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(70),
                    // image: const DecorationImage(
                    //     image: AssetImage('images/ava.jpg'),
                    //     fit: BoxFit.cover)
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.person,
                      size: 50,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  userController.user.value!.username!,
                  style: const TextStyle(color: Colors.white),
                )
              ],
            ),
            Container(
              margin: EdgeInsets.only(left: 20),
              alignment: Alignment.topCenter,
              child: Text(
                userController.user.value!.status!,
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ));
  }

  List<Widget> loggedDrawer() {
    return [
      drawerHeader(),
      listForDrawer('Жеке кабинет', Icons.person, '/profile'),
      // listForDrawer('Стать водителем', Icons.drive_eta, '/'),
      listForDrawer('Ұсыныстар тарихы', Icons.history, '/history'),
      // listForDrawer('Вакансии', Icons.work, '/vacancies'),
    ];
  }

  List<Widget> authDrawer() {
    return [
      SizedBox(height: 80),
      listForDrawer('Регестрация', Icons.account_circle, '/register'),
      listForDrawer('Кіру', Icons.login, '/login'),
      // listForDrawer('Вакансии', Icons.work, '/vacancies'),
    ];
  }

  List<Widget> ownerDrawer() {
    return [
      drawerHeader(),
      listForDrawer('Жеке кабинет', Icons.person, '/profile'),
      listForDrawer('Ұсыныстар', Icons.request_page, '/request')
    ];
  }

  Widget bottomsheet(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        GestureDetector(
            child: Container(
              margin: EdgeInsets.only(left: 190, bottom: 40),
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(30)),
              child: const Icon(
                Icons.arrow_upward_outlined,
                color: Colors.white,
              ),
            ),
            onTap: () => showModalBottomSheet<void>(
                  isScrollControlled: true,
                  context: context,
                  builder: (BuildContext context) {
                    return Container(
                      height: 700,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30)),
                      child: bottomsheetcontext(),
                    );
                  },
                ))
      ],
    );
  }

  Widget bottomsheetcontext() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          const Text(
            'Қызметтер',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              // boxContainer(Icons.local_shipping, text: 'Жеткізу'),
              boxContainer(
                Icons.food_bank_outlined,
                text: 'Кафе',
                onTap: () => Get.toNamed('/cafes', preventDuplicates: false),
              ),
              // boxContainer(Icons.hotel, text: 'Отель'),
              // boxContainer(Icons.production_quantity_limits_outlined,
              //     text: 'Азық-түлік')
            ],
          ),
          const SizedBox(height: 20),
          // Container(
          //   padding: const EdgeInsets.only(top: 15, left: 10),
          //   width: double.maxFinite,
          //   height: 200,
          //   decoration: BoxDecoration(
          //     color: Color.fromARGB(71, 238, 195, 66),
          //     borderRadius: BorderRadius.circular(30),
          //   ),
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       const Text(
          //         'Скидка 2000тг в Еде',
          //         style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          //       ),
          //       const Text(
          //           'промокод EDA2000 на первый заказ из ресторана и доставка 0тг'),
          //       Row(
          //         mainAxisAlignment: MainAxisAlignment.end,
          //         children: const [
          //           Icon(
          //             Icons.flutter_dash,
          //             size: 30,
          //           ),
          //           Icon(
          //             IconData(0xe25a, fontFamily: 'MaterialIcons'),
          //             size: 100,
          //             color: Colors.amber,
          //           ),
          //           SizedBox(width: 20)
          //         ],
          //       )
          //     ],
          //   ),
          // )
        ],
      ),
    );
  }

  Widget boxContainer(IconData icon,
      {required String text, void Function()? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            width: 80,
            height: 80,
            decoration: BoxDecoration(
                color: Colors.blue, borderRadius: BorderRadius.circular(15)),
            child: Icon(
              icon,
              size: 40,
              color: Colors.grey[200],
            ),
          ),
          const SizedBox(height: 7),
          Text(
            text,
            style: TextStyle(color: Colors.grey[700]),
          )
        ],
      ),
    );
  }
}
