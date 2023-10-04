// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:student_app/helpers/app_colors.dart';
import 'package:student_app/model/sign_up_model.dart';
import 'package:student_app/services/sign_up_service.dart';
import 'package:student_app/view/login_screen/login_screen.dart';

class SignUpController with ChangeNotifier {
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String errorMsg = '';
  bool isObscure = true;
  bool isLoading = false;
  SignUpPostModel? signUpPostModel;

  void resetErrorState() {
    userNameController.clear();
    emailController.clear();
    passwordController.clear();
    errorMsg = '';
    notifyListeners();
  }

  void signUp(BuildContext context) async {
    isLoading = true;
    notifyListeners();
    final (msg, serviceResponse) = await SignUpService().signUp(
        signUpPostModel: SignUpPostModel(
            username: userNameController.text,
            email: emailController.text,
            password: passwordController.text));

    if (serviceResponse != null) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ));
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: AppColors.green,
          content: const Center(child: Text('Signed Up Successfully'))));
      userNameController.clear();
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
