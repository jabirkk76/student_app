// ignore_for_file: file_names, must_be_immutable

import 'package:flutter/material.dart';

class ObscureTextFormfieldWidget extends StatelessWidget {
  ObscureTextFormfieldWidget(
      {super.key,
      required this.controller,
      required this.onTap,
      required this.icon,
      required this.obscure});

  TextEditingController? controller;
  void Function()? onTap;
  Widget icon;
  bool obscure;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Enter valid credential';
        } else {
          return null;
        }
      },
      decoration: InputDecoration(
          suffixIcon: IconButton(onPressed: onTap, icon: icon),
          hintText: 'Password',
          border: const OutlineInputBorder()),
      keyboardType: TextInputType.number,
      obscureText: obscure,
    );
  }
}
