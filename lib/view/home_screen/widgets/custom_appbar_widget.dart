import 'package:flutter/material.dart';
import 'package:student_app/helpers/app_colors.dart';

class CustomAppbarWidget extends StatelessWidget {
  const CustomAppbarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      backgroundColor: AppColors.primary,
      centerTitle: true,
      title: Text(
        'LOG IN',
        style: TextStyle(fontSize: 22, color: AppColors.white),
      ),
    );
  }
}
