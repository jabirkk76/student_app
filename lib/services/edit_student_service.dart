import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:student_app_ruff/constants/constants.dart';
import 'package:student_app_ruff/model/edit_student_model.dart';
import 'package:student_app_ruff/services/prefs_manager.dart';

class EditStudentService {
  Future<EditStudentResponseModel?> edit(
      {required EditStudentPostModel editStudentPostModel,
      String? userId,
      String? studentId}) async {
    try {
      final token = await PrefsManager().getToken();
      const url = "http://${Constants.ipAddress}:3000/student/";
      final response = await http.put(
        Uri.parse(url).replace(
          queryParameters: {
            "userId": userId,
            "studentId": studentId,
          },
        ),
        body: json.encode(
          json.decode(
            json.encode(editStudentPostModel.toJson()),
          ),
        ),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json"
        },
      );
      final data = json.decode(response.body);

      if (data['success'] == true) {
        return EditStudentResponseModel.fromJson(data);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
