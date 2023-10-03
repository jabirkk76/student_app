// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:student_app/helpers/app_colors.dart';
import 'package:student_app/model/login_model.dart';
import 'package:student_app/services/login_service.dart';
import 'package:student_app/services/prefs_manager.dart';
import 'package:student_app/view/home_screen/home_screen.dart';
import 'package:student_app/view/sign_up_screen/sign_up_screen.dart';

class LoginController with ChangeNotifier {
  bool isLoading = false;
  String errorMsg = '';
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isObscure = true;
  LoginResponseModel? loginResponseModel;
  LoginPostModel? loginPostModel;

  void gotoSignUp(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const SignUpScreen(),
    ));
  }

  void login(BuildContext context) async {
    isLoading = true;
    notifyListeners();
    final (msg, serviceRespnse) = await LoginService().Login(
        loginPostModel: LoginPostModel(
            userEmail: emailController.text,
            userPassword: passwordController.text));

    if (serviceRespnse != null) {
      String userId = serviceRespnse.data.id;
      String userName = serviceRespnse.data.username;

      await PrefsManager().storeUserId(userId);
      await PrefsManager().storeUserName(userName);

      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => const HomeScreen(),
      ));

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: AppColors.green,
          content: const Center(child: Text('Logged In Successfully'))));
      emailController.clear();
      passwordController.clear();
    } else {
      errorMsg = msg!;
      notifyListeners();
    }

    isLoading = false;
    notifyListeners();
  }

  changeVisiblity() {
    isObscure = !isObscure;
    notifyListeners();
  }
}
