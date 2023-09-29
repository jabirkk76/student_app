// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class CustomTextFormFieldWidget extends StatelessWidget {
  CustomTextFormFieldWidget(
      {super.key,
      required this.controller,
      required this.hint,
      required this.keyBoard});
  TextEditingController controller;
  String? hint;
  TextInputType? keyBoard;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyBoard,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Enter valid credential';
        } else {
          return null;
        }
      },
      controller: controller,
      decoration:
          InputDecoration(hintText: hint, border: const OutlineInputBorder()),
    );
  }
}
