import 'package:flutter/material.dart';
import 'package:flutter_taxi_go/controllers/user_controller.dart';
import 'package:flutter_taxi_go/login_pages/components/auth_button.dart';
import 'package:flutter_taxi_go/login_pages/components/textfield_container.dart';
import 'package:flutter_taxi_go/models/person_module.dart';
import 'package:flutter_taxi_go/services/remote_service.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController number = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController testPaswword = TextEditingController();
  final maskPhone = MaskTextInputFormatter(mask: "8 (###)-###-##-##");
  final RxBool isPasswordEmpty = false.obs;
  final RxBool isNumberEmpty = false.obs;
  final RxBool isPasswordEmpty2 = false.obs;
  final RxBool isUsernameEmpty = false.obs;
  final TextEditingController username = TextEditingController();
  final UserController userController = Get.find<UserController>();
  RegisterPage({super.key});

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
            'Регистрация',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
          ),
          const SizedBox(height: 20),
          TextFieldContainer(
            controller: number,
            labelText: 'Телефон номер',
            icon: Icons.phone_outlined,
            inputFormatters: [maskPhone],
            keyboardType: TextInputType.number,
            showError: isNumberEmpty,
          ),
          const SizedBox(height: 10),
          TextFieldContainer(
            controller: password,
            labelText: 'Пароль',
            icon: Icons.lock,
            isPassword: true,
            showError: isPasswordEmpty,
          ),
          const SizedBox(height: 10),
          TextFieldContainer(
            controller: testPaswword,
            labelText: 'Пароль қайталаңыз',
            icon: Icons.lock,
            isPassword: true,
            showError: isPasswordEmpty2,
          ),
          const SizedBox(height: 10),
          TextFieldContainer(
            controller: username,
            labelText: 'Имя Фамилия',
            icon: Icons.account_circle,
            showError: isUsernameEmpty,
          ),
          const SizedBox(height: 20),
          AuthButton(
            text: 'Зарегистрироваться',
            onTap: () async => await register(),
          )
        ],
      ),
    );
  }

  Future<void> register() async {
    isNumberEmpty.value = number.text.isEmpty;
    isPasswordEmpty.value = password.text.isEmpty;
    isUsernameEmpty.value = username.text.isEmpty;
    isPasswordEmpty2.value = testPaswword.text.isEmpty;
    if (isNumberEmpty.value ||
        isPasswordEmpty.value ||
        isUsernameEmpty.value ||
        isPasswordEmpty2.value) {
      return;
    }
    isNumberEmpty.value = false;
    isPasswordEmpty.value = false;
    await RemoteService.register(PersonModule(
            number: number.text,
            password: password.text,
            username: username.text))
        .then((value) {
      if (value != null && value.token != "") {
        userController.user.value = User(
            username: username.text,
            password: password.text,
            number: number.text,
            token: value.token);
        Get.back();
        return;
      }

      Get.snackbar('TaxiGo', 'Регистрация не удался');
    });
  }
}
