import 'package:http/http.dart' as http;
import 'package:student_app/model/student_list_model.dart';

import 'dart:convert';

import 'prefs_manager.dart';

class StudentsService {
  Future<
      (
        String?,
        List<StudentModel>?,
      )> getAllStudents({required String? userId}) async {
    try {
      final token = await PrefsManager().getToken();

      final url = "https://std-app-server.onrender.com/student/all/$userId";

      final response = await http.get(
        Uri.parse(
          url,
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
