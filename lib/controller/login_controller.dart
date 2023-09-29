import 'package:flutter/material.dart';
import 'package:student_app_ruff/helpers/app_colors.dart';
import 'package:student_app_ruff/model/login_model.dart';
import 'package:student_app_ruff/services/login_service.dart';
import 'package:student_app_ruff/services/prefs_manager.dart';
import 'package:student_app_ruff/view/home_screen/home_screen.dart';
import 'package:student_app_ruff/view/sign_up_screen/sign_up_screen.dart';

class LoginController with ChangeNotifier {
  bool isLoading = false;
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

  void login(BuildContext context) {
    isLoading = true;
    notifyListeners();
    LoginService()
        .Login(
            loginPostModel: LoginPostModel(
                userEmail: emailController.text,
                userPassword: passwordController.text))
        .then((serviceResponse) {
      if (serviceResponse != null) {
        String userId = serviceResponse.data!.id ?? "";
        String userName = serviceResponse.data!.username;

        PrefsManager().storeUserId(userId);
        PrefsManager().storeUserName(userName);

        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ));

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: AppColors.green,
            content: const Center(child: Text('Logged In Successfully'))));
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
