// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:student_app/helpers/app_colors.dart';
import 'package:student_app/helpers/app_sizes.dart';

class CustomSettingsWidget extends StatelessWidget {
  CustomSettingsWidget(
      {super.key, required this.onTap, required this.text, required this.icon});
  IconData? icon;
  String text;
  void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      child: Row(
        children: [
          Icon(
            icon,
            color: AppColors.black,
          ),
          AppSizes.szdw20,
          Text(
            text,
            style: TextStyle(fontSize: 20, color: AppColors.black),
          ),
        ],
      ),
    );
  }
}
