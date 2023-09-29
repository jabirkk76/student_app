import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_app_ruff/controller/login_controller.dart';
import 'package:student_app_ruff/helpers/app_colors.dart';
import 'package:student_app_ruff/helpers/app_sizes.dart';
import 'package:student_app_ruff/widgets/custom_elevated_button_widget.dart';
import 'package:student_app_ruff/widgets/custom_text_form_field_widget.dart';
import 'package:student_app_ruff/widgets/obscure_text_form_field-widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  late final loginController =
      Provider.of<LoginController>(context, listen: false);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: AppColors.primary,
          centerTitle: true,
          title: Text(
            'LOG IN',
            style: TextStyle(fontSize: 22, color: AppColors.white),
          )),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: formKey,
            child: Consumer<LoginController>(
              builder: (context, value, child) => Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomTextFormFieldWidget(
                          keyBoard: TextInputType.name,
                          controller: loginController.emailController,
                          hint: 'Email ID'),
                      AppSizes.szdh20,
                      ObscureTextFormfieldWidget(
                        controller: loginController.passwordController,
                        icon: Icon(
                          value.isObscure
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        obscure: value.isObscure,
                        onTap: () {
                          value.changeVisiblity();
                        },
                      ),
                      AppSizes.szdh20,
                      CustomElevatedButtonWidget(
                        text: 'LOGIN',
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            loginController.login(context);
                          }
                        },
                      ),
                      AppSizes.szdh20,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Text('Don\'t have an account?'),
                          TextButton(
                              onPressed: () {
                                loginController.gotoSignUp(context);
                              },
                              child: Text(
                                'SIGN UP',
                                style: TextStyle(color: AppColors.blue),
                              ))
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
