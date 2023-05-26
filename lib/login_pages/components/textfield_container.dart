import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class TextFieldContainer extends StatelessWidget {
  TextFieldContainer(
      {super.key,
      required this.controller,
      this.inputFormatters,
      required this.labelText,
      required this.icon,
      this.keyboardType,
      this.isPassword = false,
      this.showError,
      this.onTap});
  final TextEditingController controller;
  final bool isPassword;
  final List<TextInputFormatter>? inputFormatters;
  final String labelText;
  final IconData icon;
  final TextInputType? keyboardType;
  final void Function()? onTap;
  final isVisible = true.obs;
  final RxBool? showError;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            margin: const EdgeInsets.only(left: 30, right: 30),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.grey[600]!),
                borderRadius: BorderRadius.circular(15)),
            child: Obx(() => TextFormField(
                  textInputAction: TextInputAction.next,
                  keyboardType: keyboardType,
                  controller: controller,
                  obscureText: Rx(isPassword).value ? isVisible.value : false,
                  cursorColor: Colors.grey[600]!,
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[600]!),
                  inputFormatters: inputFormatters,
                  decoration: InputDecoration(

                      //errorText: 'Обьязательное поле',
                      labelText: labelText,
                      labelStyle: TextStyle(color: Colors.grey[600]!),
                      hintStyle: TextStyle(
                        color: Colors.grey[600]!,
                        fontSize: 12,
                      ),
                      icon: Icon(
                        icon,
                        color: Colors.grey[600]!,
                      ),
                      border: InputBorder.none,
                      suffix: isPassword
                          ? Obx(() => GestureDetector(
                                child: isVisible.value
                                    ? const Icon(
                                        Icons.visibility,
                                        color: Colors.black,
                                      )
                                    : const Icon(
                                        Icons.visibility_off,
                                        color: Colors.black,
                                      ),
                                onTap: () => {
                                  isVisible.value = !isVisible.value,
                                  print(isVisible)
                                },
                              ))
                          : null),
                ))),
        showError != null ? ErrorW(showError!) : const SizedBox()
      ],
    );
  }

  Widget ErrorW(RxBool condition) {
    return Obx(() => condition.value
        ? const Padding(
            padding: EdgeInsets.only(left: 35),
            child: Text(
              'поле обязательное',
              style: const TextStyle(color: Colors.red),
            ),
          )
        : const SizedBox());
  }
}
