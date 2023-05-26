import 'package:flutter/material.dart';
import 'package:flutter_taxi_go/controllers/user_controller.dart';
import 'package:flutter_taxi_go/login_pages/components/auth_button.dart';
import 'package:flutter_taxi_go/login_pages/components/textfield_container.dart';
import 'package:flutter_taxi_go/models/person_module.dart';
import 'package:flutter_taxi_go/models/register_data_module.dart';
import 'package:flutter_taxi_go/models/token_module.dart';
import 'package:flutter_taxi_go/services/remote_service.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class LoginPage extends StatelessWidget {
  final maskPhone = MaskTextInputFormatter(mask: "8 (###)-###-##-##");
  final TextEditingController password = TextEditingController();
  final TextEditingController number = TextEditingController();
  final RxBool isPasswordEmpty = false.obs;
  final RxBool isNumberEmpty = false.obs;
  final UserController userController = Get.find();
  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 70),
          Row(
            children: [
              IconButton(
                  onPressed: () => {Get.back()},
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.black,
                  ))
            ],
          ),
          const SizedBox(height: 150),
          const Text(
            'Кіру',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
          ),
          const SizedBox(height: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFieldContainer(
                  controller: number,
                  labelText: 'Телефон номер',
                  icon: Icons.phone_outlined,
                  inputFormatters: [maskPhone],
                  keyboardType: TextInputType.number,
                  showError: isNumberEmpty),
            ],
          ),
          const SizedBox(height: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFieldContainer(
                  controller: password,
                  labelText: 'Пароль',
                  icon: Icons.lock,
                  isPassword: true,
                  showError: isPasswordEmpty),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: const [
              Expanded(child: SizedBox()),
              Text(
                'Пароль ұмыттыңыз?',
                style: TextStyle(color: Colors.blue),
              ),
              SizedBox(
                width: 40,
              )
            ],
          ),
          const SizedBox(height: 15),
          AuthButton(text: 'Кіру', onTap: () async => await login())
        ],
      ),
    );
  }

  Future<void> login() async {
    RegisterData token;
    isNumberEmpty.value = number.text.isEmpty;
    isPasswordEmpty.value = password.text.isEmpty;
    if (isNumberEmpty.value || isPasswordEmpty.value) {
      return;
    }
    isNumberEmpty.value = false;
    isPasswordEmpty.value = false;
    await RemoteService.logPerson(
            PersonModule(number: number.text, password: password.text))
        .then((value) {
      if (value != null) {
        token = value;
        userController.user.value = User(
            password: password.text,
            number: number.text,
            username: token.username,
            token: token.token,
            status: token.status);
        Get.back();
        return;
      }
      Get.snackbar('TaxiGo', 'Қате логин немесе пароль');
    });
  }
}
