import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:student_app/model/add_student_model.dart';

import 'prefs_manager.dart';

class AddStudentService {
  Future<(String?, AddStudentResponseModel?)> add({
    required AddStudentPostModel addStudentPostModel,
  }) async {
    try {
      final token = await PrefsManager().getToken();
      const url = "https://std-app-server.onrender.com/student/";
      final response = await http.post(
        Uri.parse(url),
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
      log(response.body);
      if (data['success'] == true) {
        return (null, AddStudentResponseModel.fromJson(data));
      } else {
        return (
          'Fetching details failed',
          null,
        );
      }
    } catch (e) {
      log(e.toString());
      return (
        'Something went wrong',
        null,
      );
    }
  }
}
