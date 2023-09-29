import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:student_app_ruff/controller/home_controller.dart';
import 'package:student_app_ruff/helpers/app_colors.dart';
import 'package:student_app_ruff/model/delete_all_model.dart';
import 'package:student_app_ruff/services/delete_all_students_service.dart';
import 'package:student_app_ruff/services/prefs_manager.dart';
import 'package:student_app_ruff/view/login_screen/login_screen.dart';

import 'package:url_launcher/url_launcher.dart';

class SettingsController with ChangeNotifier {
  SettingsController() {
    fetchUserName();
  }
  bool isLoading = false;

  DeleteAllModel? deleteAllModel;
  String? storedUserId;
  String? storedUserName;

  fetchUserName() async {
    storedUserName = await PrefsManager().getUserName();
    notifyListeners();
  }

  void deleteAllStudents(
    BuildContext context,
  ) async {
    storedUserId = await PrefsManager().getUserId();

    isLoading = true;
    notifyListeners();
    DeleteAllStudentsService()
        .deleteAll(
      context,
      userId: storedUserId.toString(),
    )
        .then((serviceResponse) {
      if (serviceResponse != null) {
        deleteAllModel = serviceResponse;

        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: AppColors.green,
            content: const Center(child: Text('Deleted Successfully')),
          ),
        );
        Provider.of<HomeController>(context, listen: false).getAllStudents();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: AppColors.red,
            content: const Center(child: Text('Not deleted'))));
      }
    });
    isLoading = false;
    notifyListeners();
  }

  Future<void> logout(BuildContext context) async {
    await PrefsManager().logOut();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: AppColors.green,
        content: const Center(child: Text('Logged out successfully'))));
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => const LoginScreen(),
    ));
  }

  void share() async {
    await Share.share('https://github.com/jabirkk76/money_saver');
    notifyListeners();
  }

  Future<void> help() async {
    await launchUrl(Uri.parse('mailto:jabirkk76@gmail.com'));
    notifyListeners();
  }
}
