// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:student_app/helpers/app_colors.dart';
import 'package:student_app/model/student_list_model.dart';
import 'package:student_app/services/delete_student_service.dart';
import 'package:student_app/services/prefs_manager.dart';
import 'package:student_app/services/students_service.dart';
import 'package:student_app/view/settings_screen/settings_screen.dart';

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
      /// [getAllStudents] return cheyyunna messagineyum serviceRespnse neyum
      /// [msg] , [serviceRespnse] enna 2 variableslekk asign chyth vekunnu.
      ///
      final (msg, serviceRespnse) = await StudentsService()
          .getAllStudents(userId: storedUserId.toString());

      /// serviceRespnse null aavathe irikkuka try ilnn return chymbol mathraman
      if (serviceRespnse != null) {
        students = serviceRespnse;
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
    final (msg, deleted) = await DeleteStudentService().delete(context,
        userId: storedUserId.toString(), studentId: studentId.toString());

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
      errorMsg = msg!;
      notifyListeners();
    }
    isLoading = false;
    notifyListeners();
  }

  gotoSettings(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const SettingsScreen(),
    ));
  }
}
