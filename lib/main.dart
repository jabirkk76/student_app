import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:student_app_ruff/controller/add_student_controller.dart';
import 'package:student_app_ruff/controller/home_controller.dart';
import 'package:student_app_ruff/controller/login_controller.dart';
import 'package:student_app_ruff/controller/settings_controller.dart';
import 'package:student_app_ruff/controller/sign_up_controller.dart';
import 'package:student_app_ruff/controller/splash_controller.dart';
import 'package:student_app_ruff/helpers/app_colors.dart';

import 'view/splash_screen/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => LoginController(),
        ),
        ChangeNotifierProvider(
          create: (context) => SignUpController(),
        ),
        ChangeNotifierProvider(
          create: (context) => SplashController(),
        ),
        ChangeNotifierProvider(
          create: (context) => HomeController(),
        ),
        ChangeNotifierProvider(
          create: (context) => AddStudentController(),
        ),
        ChangeNotifierProvider(
          create: (context) => SettingsController(),
        )
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            fontFamily: 'PTSansCaption',
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
            appBarTheme: AppBarTheme(
              centerTitle: true,
              iconTheme: IconThemeData(
                color: AppColors.white,
              ),
            ),
          ),
          home: const SplashScreen()),
    );
  }
}