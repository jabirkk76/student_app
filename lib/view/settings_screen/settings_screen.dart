import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_app_ruff/controller/settings_controller.dart';
import 'package:student_app_ruff/helpers/app_colors.dart';
import 'package:student_app_ruff/helpers/app_sizes.dart';
import 'package:student_app_ruff/view/settings_screen/widgets/custom_settings_widget.dart';
import 'package:student_app_ruff/widgets/custom_elevated_button_widget.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        centerTitle: true,
        title: Consumer<SettingsController>(
          builder: (context, value, child) => Text(
            'Settings',
            style: TextStyle(color: AppColors.white),
          ),
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.all(20),
          child: Consumer<SettingsController>(
            builder: (context, value, child) {
              return Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "hi ${value.storedUserName ?? ""} ,",
                        style: TextStyle(fontSize: 22, color: AppColors.black),
                      ),
                    ],
                  ),
                  AppSizes.szdh30,
                  CustomSettingsWidget(
                    onTap: () {
                      value.deleteAllStudents(context);
                    },
                    text: 'Delete All',
                    icon: Icons.delete,
                  ),
                  AppSizes.szdh20,
                  CustomSettingsWidget(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return Dialog(
                            child: SizedBox(
                              height: 200,
                              child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                              color: AppColors.primary,
                                              shape: BoxShape.circle),
                                          height: 50,
                                          width: 50,
                                          child: const Center(
                                            child: Text(
                                              'STUDU',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        const Text('STUDU'),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        const Text(' v.1.0.0.1'),
                                      ],
                                    ),
                                    AppSizes.szdh20,
                                    const Text(
                                        'This is your Student app. Designed for saving the details of your students.'),
                                    AppSizes.szdh20,
                                    const Row(
                                      children: [
                                        Text('DEVELOPED BY'),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          'JABIR K.K.',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                    text: 'About Us',
                    icon: Icons.details_outlined,
                  ),
                  AppSizes.szdh20,
                  CustomSettingsWidget(
                    onTap: () {
                      value.help();
                    },
                    text: 'Help',
                    icon: Icons.help,
                  ),
                  AppSizes.szdh20,
                  CustomSettingsWidget(
                    onTap: () {
                      value.share();
                    },
                    text: 'Share',
                    icon: Icons.share,
                  ),
                  AppSizes.szdh40,
                  CustomElevatedButtonWidget(
                    onTap: () async {
                      value.logout(context);
                    },
                    text: 'LOG OUT',
                  ),
                ],
              );
            },
          )),
    );
  }
}
