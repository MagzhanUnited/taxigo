import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';

class MyButton extends StatelessWidget {
  void Function()? onTap;
  bool selected;
  String text;
  Color? color;
  MyButton(
      {super.key,
      required this.onTap,
      required this.selected,
      required this.text,
      this.color});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        margin: const EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
            color: color ?? (selected ? Colors.blue : Colors.white),
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
}
