import 'package:http/http.dart' as http;

import 'dart:convert';

import 'package:student_app_ruff/constants/constants.dart';
import 'package:student_app_ruff/model/student_details_model.dart';
import 'package:student_app_ruff/services/prefs_manager.dart';

class StudentDetailService {
  Future<StudentDetailModel?> details(
      {required String? userId, required String? studentId}) async {
    try {
      final token = await PrefsManager().getToken();
      const url = "http://${Constants.ipAddress}:3000/student/one/";

      final response = await http.get(
        Uri.parse(url).replace(
          queryParameters: {"userId": userId, "studentId": studentId},
        ),
        headers: {
          "Authorization": "Bearer $token",
        },
      );
      final data = json.decode(response.body);
      if (response.statusCode == 200) {
        return StudentDetailModel.fromJson(data);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
