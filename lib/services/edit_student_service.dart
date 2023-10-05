import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:student_app/model/edit_student_model.dart';

import 'prefs_manager.dart';

class EditStudentService {
  Future<(String?, EditStudentResponseModel?)> edit(
      {required EditStudentPostModel editStudentPostModel,
      String? userId,
      String? studentId}) async {
    try {
      final token = await PrefsManager().getToken();
      const url = "https://std-app-server.onrender.com/student/";
      final response = await http.put(
        Uri.parse(url),
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
        return (null, EditStudentResponseModel.fromJson(data));
      } else {
        return ('Fetching details failed', null);
      }
    } catch (e) {
      return ('Something went wrong', null);
    }
  }
}
