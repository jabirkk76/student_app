// ignore_for_file: use_build_context_synchronously, unused_local_variable

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import 'package:student_app_ruff/constants/constants.dart';

import 'prefs_manager.dart';

class DeleteStudentService {
  Future<bool> delete(BuildContext context,
      {required String userId, required String studentId}) async {
    try {
      final token = await PrefsManager().getToken();
      const url =
          'http://${Constants.ipAddress}:3000/student/64fdedc6ef57a7d60d8b7e5a?studentId=6509c0a11339e4443100411b&userId=650970c71339e44431003dba';
      final response = await http.delete(
          Uri.parse(url).replace(
            queryParameters: {
              "userId": userId,
              "studentId": studentId,
            },
          ),
          headers: {"Authorization": "Bearer $token"});

      if (response.statusCode == 204) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
