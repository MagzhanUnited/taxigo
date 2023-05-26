import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_taxi_go/controllers/order_conrtoller.dart';
import 'package:flutter_taxi_go/controllers/user_controller.dart';
import 'package:flutter_taxi_go/login_pages/components/my_button.dart';
import 'package:flutter_taxi_go/models/book_data_module.dart';
import 'package:flutter_taxi_go/models/book_food_data_module.dart';
import 'package:flutter_taxi_go/models/inner_data_module.dart';
import 'package:flutter_taxi_go/models/order_list_module.dart';
import 'package:flutter_taxi_go/services/remote_service.dart';
import 'package:get/get.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:intl/intl.dart';

class InnerCafePage extends StatelessWidget {
  final UserController userController = Get.find();
  final int id = Get.arguments["id"];
  final String name = Get.arguments["name"];
  final RxInt pageIndex = 0.obs;
  final RxBool selectedButton1 = true.obs;
  final RxBool selectedButton2 = false.obs;
  final RxBool selectedButton3 = false.obs;
  OrderController orderController = Get.put(OrderController());
  final images = [].obs;
  InnerCafePage({super.key});
  TextEditingController amount = TextEditingController();
  TextEditingController special = TextEditingController();
  TextEditingController dateInput = TextEditingController();
  TextEditingController timeInput = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController foodname = TextEditingController();
  TextEditingController url = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(name),
          leading: IconButton(
              onPressed: () => Get.back(),
              icon: const Icon(Icons.arrow_back_ios)),
        ),
        body: FutureBuilder(
            future: RemoteService.getInner(id),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return SafeArea(
                child: Stack(
                  children: [
                    SingleChildScrollView(
                      child: Obx(() => Padding(
                            padding: const EdgeInsets.only(
                                right: 10, left: 10, bottom: 80),
                            child: header(data: snapshot.data!),
                          )),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (!selectedButton3.value) {
                              dialog(context);
                              return;
                            }
                            if (userController.user.value != null &&
                                selectedButton3.value &&
                                userController.user.value!.status == 'Егесі') {
                              print('%%%%%%%%%%%%%%%%%');
                              Get.defaultDialog(
                                  title: 'Добавить еду',
                                  content: Container(
                                    width: 500,
                                    height: 300,
                                    child: Column(
                                      children: [
                                        MyTextField('Название',
                                            controller: foodname),
                                        MyTextField('Цена', controller: price),
                                        MyTextField('url изоброжение',
                                            controller: url),
                                        Expanded(child: SizedBox()),
                                        Row(
                                          children: [
                                            Expanded(child: SizedBox()),
                                            GestureDetector(
                                              child: Button('Добавить'),
                                              onTap: () async =>
                                                  await RemoteService
                                                          .postFoodBook(
                                                              BookFoodData(
                                                                  name: foodname
                                                                      .text,
                                                                  price: price
                                                                      .text,
                                                                  place: name,
                                                                  image:
                                                                      url.text))
                                                      .then((value) => value
                                                          ? Get.back()
                                                          : Get.snackbar(
                                                              'failed',
                                                              'error')),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ));
                              return;
                            }
                            if (selectedButton3.value) {
                              print("#############");
                              Get.defaultDialog(
                                  title: 'Тапсырыс',
                                  content: Column(
                                    children: [
                                      Column(
                                          children: List.generate(
                                              orderController.order.length,
                                              (index) => Row(
                                                    children: [
                                                      Text(orderController
                                                          .order[index].name),
                                                      Expanded(
                                                          child: SizedBox()),
                                                      Container(
                                                        child: Text(
                                                            orderController
                                                                .order[index]
                                                                .price
                                                                .toString()),
                                                      )
                                                    ],
                                                  ))),
                                      SizedBox(height: 10),
                                      Row(
                                        children: [
                                          Expanded(child: SizedBox()),
                                          GestureDetector(
                                            child: Button('Тапсырыс'),
                                            onTap: () async {
                                              var orders = <Order>[];
                                              for (var i
                                                  in orderController.order) {
                                                var order = Order(
                                                    name: i.name,
                                                    amount: i.amount.toString(),
                                                    price: i.price.toString());
                                                orders.add(order);
                                              }
                                              var orderlist = OrderList(
                                                  place: name,
                                                  number: userController
                                                      .user.value!.number!,
                                                  orders: orders);
                                              print(orderlist.number);
                                              print(orderlist.place);
                                              for (var i in orderlist.orders) {
                                                print(i.amount);
                                                print(i.name);
                                                print(i.price);
                                              }
                                              await RemoteService.postOrder(
                                                  orderlist);
                                            },
                                          )
                                        ],
                                      )
                                    ],
                                  ));
                              return;
                            }
                          },
                          child: Container(
                            margin: const EdgeInsets.only(
                                bottom: 20, right: 75, left: 75),
                            width: double.maxFinite,
                            height: 50,
                            decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(20)),
                            child: Obx(() => Center(
                                  child: !selectedButton3.value
                                      ? const Text(
                                          'Брондау',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20),
                                        )
                                      : (userController.user.value != null) &&
                                              (userController
                                                      .user.value!.status ==
                                                  'Егесі')
                                          ? const Text(
                                              'Қосу',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20),
                                            )
                                          : const Text(
                                              'Тапсырыс',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20),
                                            ),
                                )),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              );
            }));
  }

  Widget buttons(String text, bool selected, {void Function()? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        margin: const EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
            color: selected ? Colors.blue : Colors.white,
            borderRadius: BorderRadius.circular(10),
            border:
                selected ? null : Border.all(width: 1.5, color: Colors.blue)),
        child: Text(
          text,
          style: selected
              ? const TextStyle(color: Colors.white)
              : const TextStyle(color: Colors.black),
        ),
      ),
    );
  }

  Widget header({required InnerData data}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 20),
          height: 200,
          width: double.maxFinite,
          child: PageView.builder(
            onPageChanged: (value) => pageIndex.value = value,
            // controller: pageController,
            itemCount: data.images.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                width: double.maxFinite,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Stack(
                  children: [
                    const Center(
                      child: CircularProgressIndicator(),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                        data.images[index],
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 10),
        Center(
          child: Obx(
            () => DotsIndicator(
              dotsCount: data.images.length,
              position: pageIndex.value,
              decorator: DotsDecorator(
                color: Colors.grey,
                size: const Size.square(9.0),
                activeSize: const Size(18.0, 9.0),
                activeColor: Colors.blue,
                activeShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Obx(
              () => MyButton(
                text: 'Басты бет',
                selected: selectedButton1.value,
                onTap: () {
                  selectedButton1.value = true;
                  selectedButton2.value = false;
                  selectedButton3.value = false;
                },
              ),
            ),
            Obx(() => MyButton(
                text: 'Меню',
                selected: selectedButton2.value,
                onTap: () {
                  selectedButton1.value = false;
                  selectedButton2.value = true;
                  selectedButton3.value = false;
                })),
            Obx(() => MyButton(
                text: 'Тапсырыс',
                selected: selectedButton3.value,
                onTap: () {
                  selectedButton1.value = false;
                  selectedButton2.value = false;
                  selectedButton3.value = true;
                }))
          ],
        ),
        selectedButton1.value
            ? mainPage(data)
            : selectedButton2.value
                ? menuPage(data)
                : orderPage()
      ],
    );
  }

  Widget mainPage(InnerData data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 15,
        ),
        Text(
          data.adress,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 15,
        ),
        Row(
          children: [
            const Text(
              'Телефон:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(data.number)
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        const Text(
          'Сипаттама',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(data.text),
        const SizedBox(
          height: 15,
        ),
      ],
    );
  }

  Widget menuPage(InnerData data) {
    fetchData();
    return Obx(() => Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Column(
              children: List.generate(
            images.length,
            (index) => Image.network(
              "https://strg1.restoran.kz/${images.value[index]}",
              errorBuilder: (context, error, stackTrace) =>
                  const Text('Ошибка'),
            ),
          )),
        ));
  }

  Widget orderPage() {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        FutureBuilder(
            future: RemoteService.getBookFood(BookFoodData(place: name)),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return SizedBox(
                  height: 400,
                  child: CustomScrollView(
                    primary: false,
                    slivers: <Widget>[
                      SliverPadding(
                        padding: const EdgeInsets.all(20),
                        sliver: SliverGrid.count(
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            crossAxisCount: 2,
                            children: List.generate(
                                snapshot.data!.length,
                                (index) =>
                                    order_card(snapshot.data![index], index))),
                      ),
                    ],
                  ));
            })
      ],
    );
  }

  Widget order_card(BookFoodData snaphot, int index) {
    var counter = 0.obs;
    return Container(
      margin: const EdgeInsets.only(left: 10),
      width: 200,
      height: 200,
      decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ]),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 10),
            width: 120,
            height: 120,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                    image: NetworkImage(snaphot.image!), fit: BoxFit.cover)),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const SizedBox(
                        width: 25,
                      ),
                      Text(
                        snaphot.price! + ' тг',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        width: 25,
                      ),
                      Text(
                        snaphot.name!,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[700]),
                      )
                    ],
                  ),
                ],
              ),
              Expanded(child: SizedBox()),
              GestureDetector(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(5)),
                  child: const Icon(
                    Icons.remove,
                    color: Colors.white,
                  ),
                ),
                onTap: () {
                  if (counter.value <= 1) {
                    orderController.order.removeAt(index);
                    counter.value = 0;
                    return;
                  }

                  counter--;
                  orderController.order[index].amount--;
                  orderController.order[index].price -=
                      int.parse(snaphot.price!);
                },
              ),
              const SizedBox(
                width: 10,
              ),
              Obx(
                () => Text(counter.value.toString()),
              ),
              const SizedBox(
                width: 10,
              ),
              GestureDetector(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(5)),
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
                onTap: () {
                  if (counter.value == 0) {
                    counter++;
                    orderController.order.insert(
                        index,
                        Orders(
                            name: snaphot.name!,
                            amount: counter.value,
                            place: name,
                            price: int.parse(snaphot.price!) * counter.value));

                    return;
                  }
                  counter++;
                  orderController.order[index].amount++;
                  orderController.order[index].price =
                      int.parse(snaphot.price!) * counter.value;
                },
              ),
              const SizedBox(
                width: 15,
              )
            ],
          )
        ],
      ),
    );
  }

  Future<void> fetchData() async {
    images.value = (await RemoteService.getMenu(id))!;
  }

  void dialog(context) {
    final DateTime pickedDate = DateTime.now();
    if (userController.user.value == null) {
      Get.toNamed('/register');
      Get.snackbar('Регистрация', 'Бронь жасау үшін авторизация міндетті');
      return;
    }

    Get.defaultDialog(
        title: 'Бронь',
        content: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          height: 450,
          width: 300,
          child: Column(
            children: [
              MyTextField('Адамдар саны', controller: amount),
              MyTextField('Ерекше ұсыныс', controller: special),
              MyTextField(DateFormat.yMd().format(pickedDate),
                  icon: const Icon(Icons.calendar_month_outlined),
                  readonly: true, onTap: () {
                print('tap');
                // Get.back();
                _picker(context, pickedDate);
              }, controller: dateInput),
              MyTextField('Уақытты таңдаңыз',
                  readonly: true,
                  onTap: () => showTimePickerWithDefault(context),
                  controller: timeInput),
              Expanded(child: SizedBox()),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    child: Button('Брондау'),
                    onTap: () => RemoteService.postBook(BookData(
                            amount: amount.text,
                            special: special.text,
                            date: dateInput.text,
                            time: timeInput.text,
                            person: userController.user.value!.username!,
                            number: userController.user.value!.number!,
                            place: name))
                        .then((value) {
                      if (value == true) {
                        Get.back();
                        Get.snackbar('Күтіңіз', 'Тапсырысыңыз сәтті жіберілді');
                        amount.clear();
                        dateInput.clear();
                        timeInput.clear();
                        special.clear();
                      }
                    }),
                  )
                ],
              )
            ],
          ),
        ));
  }

  Future<void> _picker(context, DateTime? pickedDate) async {
    pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        //DateTime.now() - not to allow to choose before today.
        lastDate: DateTime(2100));

    if (pickedDate != null) {
      print(pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      print(
          formattedDate); //formatted date output using intl package =>  2021-03-16

      dateInput.text = formattedDate; //set output date to TextField value.
    } else {
      print('null');
    }
  }

  Future<void> showTimePickerWithDefault(BuildContext context) async {
    TimeOfDay initialTime = TimeOfDay(hour: 23, minute: 0);

    final selectedTime = await showTimePicker(
      context: context,
      initialTime: initialTime,
      builder: (context, child) => Theme(
        data: ThemeData(
          primaryColor: Colors.blue,
        ),
        child: child!,
      ),
    );

    if (selectedTime != null) {
      // Handle the selected time
      print('Selected time: ${selectedTime.hour}');
      timeInput.text =
          selectedTime.hour.toString() + ":" + selectedTime.minute.toString();
    }
  }

  Widget MyTextField(String text,
      {Widget? icon,
      bool readonly = false,
      void Function()? onTap,
      TextEditingController? controller}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 1.5, color: Colors.grey[200]!)),
      child: TextField(
        controller: controller,
        readOnly: readonly,
        cursorColor: Colors.blue,
        decoration: InputDecoration(
          hintText: text,
          border: InputBorder.none,
          suffixIcon: icon,
          suffixIconColor: Colors.grey,
        ),
        onTap: onTap,
      ),
    );
  }

  Button(text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
          color: Colors.blue, borderRadius: BorderRadius.circular(15)),
      child: Text(
        text,
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
