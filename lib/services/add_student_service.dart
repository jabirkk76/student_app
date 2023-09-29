import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import 'package:student_app_ruff/constants/constants.dart';
import 'package:student_app_ruff/model/add_student_model.dart';
import 'package:student_app_ruff/services/prefs_manager.dart';

class AddStudentService {
  Future<AddStudentResponseModel?> add({
    required AddStudentPostModel addStudentPostModel,
    String? userId,
  }) async {
    try {
      final token = await PrefsManager().getToken();
      const url = "http://${Constants.ipAddress}:3000/student/";
      final response = await http.post(
        Uri.parse(url).replace(queryParameters: {"userId": userId}),
        body: json.encode(
          json.decode(
            json.encode(addStudentPostModel.toJson()),
          ),
        ),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          "Authorization": "Bearer $token"
        },
      );
      final data = json.decode(response.body);
      if (data['success'] == true) {
        return AddStudentResponseModel.fromJson(data);
      } else {
        return null;
      }
    } catch (e) {
      log(e.toString());
      return null;
    }
  }
}
