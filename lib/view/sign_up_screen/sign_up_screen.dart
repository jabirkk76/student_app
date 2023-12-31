import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_app/helpers/app_colors.dart';
import 'package:student_app/helpers/app_sizes.dart';
import 'package:student_app/widgets/custom_elevated_button_widget.dart';
import 'package:student_app/widgets/obscure_text_form_field-widget.dart';

import '../../controller/sign_up_controller.dart';
import '../../widgets/custom_text_form_field_widget.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final RegExp emailRegExp = RegExp(
    r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
  );
  final formKey = GlobalKey<FormState>();
  late final signUpController =
      Provider.of<SignUpController>(context, listen: false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        centerTitle: true,
        title: Text(
          'SIGN UP',
          style: TextStyle(fontSize: 22, color: AppColors.white),
        ),
      ),
      body: SafeArea(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Consumer<SignUpController>(builder: (context, value, child) {
              if (value.isLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (value.errorMsg != '') {
                return Center(
                  child: Text(
                    value.errorMsg,
                    style: TextStyle(fontSize: 22, color: AppColors.red),
                  ),
                );
              }
              return Column(
                children: [
                  CustomTextFormFieldWidget(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter a Username';
                      } else {
                        return null;
                      }
                    },
                    keyBoard: TextInputType.name,
                    controller: signUpController.userNameController,
                    hint: 'Username',
                  ),
                  AppSizes.szdh20,
                  CustomTextFormFieldWidget(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter an Email ID';
                      } else if (!emailRegExp.hasMatch(value)) {
                        return 'Please enter a valid email address.';
                      } else {
                        return null;
                      }
                    },
                    keyBoard: TextInputType.name,
                    controller: signUpController.emailController,
                    hint: 'Email ID',
                  ),
                  AppSizes.szdh20,
                  ObscureTextFormfieldWidget(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter a Password';
                      } else if (value.length < 6) {
                        return 'Password must be at least 6 characters long';
                      } else {
                        return null;
                      }
                    },
                    controller: signUpController.passwordController,
                    icon: Icon(
                      value.isObscure ? Icons.visibility : Icons.visibility_off,
                    ),
                    obscure: value.isObscure,
                    onTap: () {
                      value.changeVisiblity();
                    },
                  ),
                  AppSizes.szdh20,
                  AppSizes.szdh20,
                  CustomElevatedButtonWidget(
                    text: 'SIGN UP',
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        signUpController.signUp(context);
                      }
                    },
                  ),
                  AppSizes.szdh20,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text('Already have an account?'),
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            'SIGN IN',
                            style: TextStyle(color: AppColors.blue),
                          ))
                    ],
                  )
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
