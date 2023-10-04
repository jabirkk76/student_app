// ignore_for_file: file_names, must_be_immutable

import 'package:flutter/material.dart';
import 'package:student_app/helpers/app_colors.dart';

class ObscureTextFormfieldWidget extends StatelessWidget {
  ObscureTextFormfieldWidget(
      {super.key,
      required this.controller,
      required this.onTap,
      required this.icon,
      required this.obscure,
      required this.validator});

  TextEditingController? controller;
  void Function()? onTap;
  Widget icon;
  bool obscure;
  String? Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      decoration: InputDecoration(
          fillColor: AppColors.white,
          filled: true,
          suffixIcon: IconButton(
            onPressed: onTap,
            icon: icon,
            color: AppColors.black,
          ),
          hintText: 'Password',
          hintStyle: TextStyle(color: AppColors.grey),
          border: const OutlineInputBorder()),
      obscureText: obscure,
    );
  }
}
