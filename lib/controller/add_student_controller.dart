import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_app_ruff/controller/home_controller.dart';
import 'package:student_app_ruff/helpers/app_colors.dart';
import 'package:student_app_ruff/model/add_student_model.dart';
import 'package:student_app_ruff/model/edit_student_model.dart';
import 'package:student_app_ruff/model/student_details_model.dart';
import 'package:student_app_ruff/services/add_student_service.dart';
import 'package:student_app_ruff/services/edit_student_service.dart';
import 'package:student_app_ruff/services/prefs_manager.dart';
import 'package:student_app_ruff/services/student_detail_service.dart';
import 'package:student_app_ruff/view/home_screen/home_screen.dart';

class AddStudentController with ChangeNotifier {
  bool isLoading = false;
  StudentDetailModel? studentModel;
  final TextEditingController editNameController = TextEditingController();
  final TextEditingController editAgeController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  AddStudentPostModel? createStudentPostModel;
  final domainList = ['Flutter', 'Java', 'PHP', 'Kotlin'];
  final genderList = ['Male', 'Female'];
  String? domainChosen;
  String? genderChosen;
  void changeDomainIndex(String newIndex) {
    domainChosen = newIndex;
    notifyListeners();
  }

  void changeGenderIndex(String newIndex) {
    genderChosen = newIndex;
    notifyListeners();
  }

  void getStudentDetails(BuildContext context, String? studentId) async {
    String? storedUserId = await PrefsManager().getUserId();

    isLoading = true;
    notifyListeners();
    if (storedUserId != null) {
      await StudentDetailService()
          .details(studentId: studentId, userId: storedUserId)
          .then((serviceResponse) {
        if (serviceResponse != null) {
          studentModel = serviceResponse;
          editNameController.text = studentModel?.student.name ?? "u";
          editAgeController.text = '${studentModel?.student.age ?? "hg"}';
          domainChosen = studentModel?.student.domain;
          genderChosen = studentModel?.student.gender;
          notifyListeners();
        }
      });
    }

    isLoading = false;
    notifyListeners();
  }

  void addStudent(
    BuildContext context,
  ) async {
    String? storedUserId = await PrefsManager().getUserId();
    isLoading = true;
    notifyListeners();
    if (storedUserId != null) {
      await AddStudentService()
          .add(
        addStudentPostModel: AddStudentPostModel(
          name: nameController.text,
          age: ageController.text,
          domain: domainChosen.toString(),
          gender: genderChosen.toString(),
        ),
        userId: storedUserId,
      )
          .then((serviceResponse) {
        if (serviceResponse != null) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: AppColors.green,
              content: const Center(child: Text('New Student Created'))));
          Provider.of<HomeController>(context, listen: false).getAllStudents();
          notifyListeners();
          nameController.clear();
          ageController.clear();

          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ));
        } else {
          return null;
        }
      });
    }

    isLoading = false;
    notifyListeners();
  }

  void editStudent(BuildContext context, {required String studentId}) async {
    String? storedUserId = await PrefsManager().getUserId();
    isLoading = true;
    notifyListeners();

    if (storedUserId != null) {
      await EditStudentService()
          .edit(
        userId: storedUserId,
        studentId: studentId,
        editStudentPostModel: EditStudentPostModel(
          name: editNameController.text.isEmpty
              ? studentModel?.student.name ?? ""
              : editNameController.text,
          age: editAgeController.text.isEmpty
              ? studentModel?.student.age.toString() ?? ""
              : editAgeController.text,
          domain: domainChosen ?? studentModel?.student.domain.toString() ?? "",
          gender: genderChosen ?? studentModel?.student.gender.toString() ?? "",
        ),
      )
          .then((serviceResponse) {
        if (serviceResponse != null) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: AppColors.green,
              content: const Center(child: Text('Edited successfully'))));
        } else {
          return null;
        }
      });
    }

    isLoading = false;
    notifyListeners();
  }
}
