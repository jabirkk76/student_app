import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:student_app/services/prefs_manager.dart';
import 'package:student_app/view/home_screen/home_screen.dart';
import 'package:student_app/view/login_screen/login_screen.dart';

class SplashController with ChangeNotifier {
  Future<void> splash(BuildContext context) async {
    String? storedUserId = await PrefsManager().getUserId();

    await Future.delayed(const Duration(seconds: 3));

    if (storedUserId != null) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => const HomeScreen(),
      ));
    } else {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ));
    }
  }
}
