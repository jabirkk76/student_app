// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:student_app_ruff/helpers/app_colors.dart';
import 'package:student_app_ruff/model/student_list_model.dart';
import 'package:student_app_ruff/services/delete_student_service.dart';
import 'package:student_app_ruff/services/prefs_manager.dart';
import 'package:student_app_ruff/services/students_service.dart';
import 'package:student_app_ruff/view/settings_screen/settings_screen.dart';

class HomeController with ChangeNotifier {
  HomeController() {
    getAllStudents();
  }
  bool isLoading = false;
  String errorMsg = '';

  List<StudentModel> students = [];

  void getAllStudents({String? userId}) async {
    String? storedUserId = await PrefsManager().getUserId();

    isLoading = true;
    notifyListeners();

    if (storedUserId != null) {
      /// [getAllStudents] return cheyyunna messagineyum studentList neyum
      /// [msg] , [studentList] enna 2 variableslekk asign chyth vekunnu.
      ///
      final (msg, studentList) = await StudentsService()
          .getAllStudents(userId: storedUserId.toString());

      /// studentList null aavathe irikkuka try ilnn return chymbol mathraman
      if (studentList != null) {
        students = studentList;
        notifyListeners();
      } else /* error aanenkil */ {
        errorMsg = msg!;
        notifyListeners();
      }
    }
    isLoading = false;
    notifyListeners();
  }

  void deleteStudent(BuildContext context, {String? studentId}) async {
    String? storedUserId = await PrefsManager().getUserId();
    isLoading = true;
    notifyListeners();
    await DeleteStudentService()
        .delete(context,
            userId: storedUserId.toString(), studentId: studentId.toString())
        .then((deleted) {
      if (deleted == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: AppColors.green,
            content: const Center(child: Text('Deleted Successfully')),
          ),
        );
        Navigator.of(context).pop();
        getAllStudents();
        notifyListeners();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: AppColors.red,
            content: const Center(child: Text('Not deleted'))));
      }
      isLoading = false;
      notifyListeners();
    });
  }

  gotoSettings(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const SettingsScreen(),
    ));
  }
}
