// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:student_app/helpers/app_colors.dart';

class CustomTextFormFieldWidget extends StatelessWidget {
  CustomTextFormFieldWidget(
      {super.key,
      required this.controller,
      required this.hint,
      required this.keyBoard,
      required this.validator});
  TextEditingController controller;
  String? hint;
  TextInputType? keyBoard;
  String? Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyBoard,
      validator: validator,
      controller: controller,
      decoration: InputDecoration(
          fillColor: AppColors.white,
          filled: true,
          hintText: hint,
          hintStyle: TextStyle(color: AppColors.grey),
          border: const OutlineInputBorder()),
    );
  }
}
