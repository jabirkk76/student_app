import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_app/controller/home_controller.dart';
import 'package:student_app/helpers/app_colors.dart';
import 'package:student_app/model/add_student_model.dart';
import 'package:student_app/model/edit_student_model.dart';
import 'package:student_app/model/student_details_model.dart';
import 'package:student_app/services/add_student_service.dart';
import 'package:student_app/services/edit_student_service.dart';
import 'package:student_app/services/prefs_manager.dart';
import 'package:student_app/services/student_detail_service.dart';

class AddStudentController with ChangeNotifier {
  bool isLoading = false;
  StudentDetailModel? studentModel;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  AddStudentPostModel? createStudentPostModel;
  final domainList = ['Flutter', 'Java', 'PHP', 'Kotlin'];
  final genderList = ['Male', 'Female'];
  String? domainChosen;
  String? genderChosen;
  String errorMsg = '';
  void changeDomainIndex(String newIndex) {
    domainChosen = newIndex;
    notifyListeners();
  }

  void changeGenderIndex(String newIndex) {
    genderChosen = newIndex;
    notifyListeners();
  }

  void getStudentDetails(BuildContext context, String? studentId) async {
    isLoading = true;
    notifyListeners();

    final (msg, serviceResponse) = await StudentDetailService().details(
      studentId: studentId,
    );

    if (serviceResponse != null) {
      studentModel = serviceResponse;
      nameController.text = studentModel?.student.name ?? "u";
      ageController.text = '${studentModel?.student.age ?? "hg"}';
      domainChosen = studentModel?.student.domain;
      genderChosen = studentModel?.student.gender;

      notifyListeners();
    } else {
      errorMsg = msg!;
      notifyListeners();
    }

    isLoading = false;
    notifyListeners();
  }

  void addStudent(
    BuildContext context,
  ) async {
    isLoading = true;
    notifyListeners();
    String? storedUserId = await PrefsManager().getUserId();
    final (msg, serviceResponse) = await AddStudentService().add(
      addStudentPostModel: AddStudentPostModel(
          name: nameController.text,
          age: ageController.text,
          domain: domainChosen.toString(),
          gender: genderChosen.toString(),
          userId: storedUserId.toString()),
    );

    if (serviceResponse != null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: AppColors.green,
          content: const Center(child: Text('New Student Created'))));
      Provider.of<HomeController>(context, listen: false).getAllStudents();
      notifyListeners();
      nameController.clear();
      ageController.clear();

      Navigator.of(context).pop();
    } else {
      errorMsg = msg!;
      notifyListeners();
    }
    isLoading = false;
    notifyListeners();
  }

  void editStudent(BuildContext context, {required String studentId}) async {
    isLoading = true;
    notifyListeners();

    final (msg, serviceResponse) = await EditStudentService().edit(
      editStudentPostModel: EditStudentPostModel(
        studentId: studentId,
        name: nameController.text.isEmpty
            ? studentModel?.student.name ?? ""
            : nameController.text,
        age: ageController.text.isEmpty
            ? studentModel?.student.age ??
                0 // Use a default value if age is null
            : int.tryParse(ageController.text) ??
                0, // Parse the age or use a default value if parsing fails

        domain: domainChosen ?? studentModel?.student.domain.toString() ?? "",
        gender: genderChosen ?? studentModel?.student.gender.toString() ?? "",
      ),
    );

    if (serviceResponse != null) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: AppColors.green,
          content: const Center(child: Text('Edited successfully'))));
    } else {
      errorMsg = msg!;
      notifyListeners();
    }

    isLoading = false;
    notifyListeners();
  }
}
