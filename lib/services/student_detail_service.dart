import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:student_app/model/student_details_model.dart';
import 'prefs_manager.dart';

class StudentDetailService {
  Future<(String?, StudentDetailModel?)> details(
      {required String? studentId}) async {
    try {
      final token = await PrefsManager().getToken();
      final url = "https://std-app-server.onrender.com/student/one/$studentId";

      final response = await http.get(
        Uri.parse(url),
        headers: {
          "Authorization": "Bearer $token",
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final studentDetail = StudentDetailModel.fromJson(data);
        return (null, studentDetail);
      } else {
        return ('Failed to fetch student details', null);
      }
    } catch (e) {
      return ('Something went wrong', null);
    }
  }
}
