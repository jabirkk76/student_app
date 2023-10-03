// ignore_for_file: must_be_immutable, duplicate_ignore, sort_child_properties_last

// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../helpers/app_colors.dart';

class CustomElevatedButtonWidget extends StatelessWidget {
  CustomElevatedButtonWidget(
      {super.key, required this.onTap, required this.text});
  void Function()? onTap;
  String text;

  @override
  Widget build(BuildContext context) {
    return
        //  TextButton(
        //     onPressed: onTap,
        //     child: Text(
        //       text,
        //       style: TextStyle(fontSize: 20),
        //     ));
        GestureDetector(
      onTap: onTap,
      child: Container(
        child: Center(
          child: Text(
            text,
            style: TextStyle(fontSize: 20, color: AppColors.white),
          ),
        ),
        decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: const BorderRadius.all(Radius.circular(12))),
        height: 50,
        width: 150,
      ),
    );
  }
}
