import 'package:flutter/material.dart';
import 'package:student_app_ruff/helpers/app_colors.dart';
import 'package:student_app_ruff/model/sign_up_model.dart';
import 'package:student_app_ruff/services/sign_up_service.dart';
import 'package:student_app_ruff/view/login_screen/login_screen.dart';

class SignUpController with ChangeNotifier {
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isObscure = true;
  bool isLoading = false;
  SignUpPostModel? signUpPostModel;
  void signUp(BuildContext context) {
    isLoading = true;
    notifyListeners();
    SignUpService()
        .signUp(
            signUpPostModel: SignUpPostModel(
                username: userNameController.text,
                email: emailController.text,
                password: passwordController.text))
        .then((serviceResponse) {
      if (serviceResponse != null) {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ));
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: AppColors.green,
            content: const Center(child: Text('Signed Up Successfully'))));
        userNameController.clear();
        emailController.clear();
        passwordController.clear();
      } else {
        return null;
      }
    });
    isLoading = false;
    notifyListeners();
  }

  changeVisiblity() {
    isObscure = !isObscure;
    notifyListeners();
  }
}
