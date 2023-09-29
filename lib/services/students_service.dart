import 'package:http/http.dart' as http;

import 'dart:convert';

import 'package:student_app_ruff/constants/constants.dart';
import 'package:student_app_ruff/model/student_list_model.dart';

import 'prefs_manager.dart';

class StudentsService {
  Future<(String?, List<StudentModel>?)> getAllStudents(
      {required String userId}) async {
    try {
      final token = await PrefsManager().getToken();

      const url = "http://${Constants.ipAddress}:3000/student/all/";

      final response = await http.get(
        Uri.parse(
          url,
        ).replace(
          queryParameters: {
            "userId": userId,
          },
        ),
        headers: {
          "Authorization": "Bearer $token",
        },
      );
      final data = json.decode(response.body);

      List<StudentModel> studentList = ((data['students']) as List)
          .map((e) => StudentModel.fromJson(e))
          .toList();
      return (null, studentList);
    } catch (e) {
      return ('Something went wrong', null);
    }
  }
}
