import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_app/controller/settings_controller.dart';
import 'package:student_app/helpers/app_colors.dart';
import 'package:student_app/widgets/custom_elevated_button_widget.dart';

import '../../helpers/app_sizes.dart';
import 'widgets/custom_settings_widget.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key, Key? keys});

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
                              height: 270,
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
                                          height: 70,
                                          width: 70,
                                          child: const Center(
                                            child: Text(
                                              'SKILLSPIRE',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 10,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        const Text('SKILLSPIRE'),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        const Text(' v.1.0.0.1'),
                                      ],
                                    ),
                                    AppSizes.szdh20,
                                    const Text(
                                        'SkillSpire is an easy-to-use student information system to help your school save time,improve enrollment, and fullfill its mission.'),
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
