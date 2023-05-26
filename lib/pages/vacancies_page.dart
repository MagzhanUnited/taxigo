// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
// import 'package:flutter_taxi_go/controllers/user_controller.dart';
// import 'package:flutter_taxi_go/login_pages/components/my_button.dart';
// import 'package:get/get.dart';

// class VacanciesPage extends StatelessWidget {
//   final RxBool vacancies = true.obs;
//   final RxBool myOffers = false.obs;
//   final RxBool invitations = false.obs;
//   final UserController userController = Get.find();

//   VacanciesPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text('Вакансии'),
//         ),
//         body: SafeArea(
//           child: Obx(() => SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     const SizedBox(height: 10),
//                     Row(
//                       children: [
//                         const SizedBox(width: 10),
//                         MyButton(
//                           text: 'Все вакансии',
//                           selected: vacancies.value,
//                           onTap: () {
//                             vacancies.value = true;
//                             myOffers.value = false;
//                             invitations.value = false;
//                           },
//                         ),
//                         MyButton(
//                           text: 'Мои отклики',
//                           selected: myOffers.value,
//                           onTap: () {
//                             vacancies.value = false;
//                             myOffers.value = true;
//                             invitations.value = false;
//                           },
//                         ),
//                         MyButton(
//                           text: 'Приглашение',
//                           selected: invitations.value,
//                           onTap: () {
//                             vacancies.value = false;
//                             myOffers.value = false;
//                             invitations.value = true;
//                           },
//                         )
//                       ],
//                     ),
//                     vacancieContainer(
//                         'Официант в ресторан Korean house',
//                         'до 900 USD',
//                         'Rocket Tech School',
//                         'Астана',
//                         'Отличная память, презентабельный внешний вид, чёткая дикция, деликатность, ответственность, коммуникабельность, бесконфликтность. Можно без опыта работы, обучение предоставляется. Знание начального уровня иностранных языков приветствуется.'),
//                   ],
//                 ),
//               )),
//         ));
//   }

//   Widget vacancieContainer(
//       String title, String money, String company, String city, String text) {
//     return GestureDetector(
//       child: Container(
//         padding: const EdgeInsets.only(top: 15, left: 10),
//         margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
//         width: double.maxFinite,
//         // height: 220,
//         decoration: BoxDecoration(
//           color: Colors.grey[200],
//           borderRadius: BorderRadius.circular(20),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.grey.withOpacity(0.5),
//               spreadRadius: 3,
//               blurRadius: 7,
//               offset: Offset(0, 3), // changes position of shadow
//             ),
//           ],
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               overflow: TextOverflow.ellipsis,
//               maxLines: 1,
//               softWrap: false,
//               title,
//               style: const TextStyle(
//                   color: Colors.blue,
//                   fontSize: 17,
//                   fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 8),
//             Text(
//               money,
//               style: TextStyle(fontWeight: FontWeight.w700),
//             ),
//             const SizedBox(height: 10),
//             Text(company),
//             Text(city),
//             const SizedBox(height: 10),
//             Text(
//               // overflow: TextOverflow.ellipsis,
//               text,
//               maxLines: 100,
//               // softWrap: false,
//             ),
//             SizedBox(height: 15),
//             MyButton(onTap: null, selected: true, text: 'Откликнуться'),
//             const SizedBox(height: 15),
//           ],
//         ),
//       ),
//       onTap: () {
//         if (userController.user.value == null) {
//           Get.snackbar('необходимо', 'зарегистрироваться что бы откликнуться');
//           return;
//         }
//       },
//     );
//   }
// }
