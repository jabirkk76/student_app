import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import 'package:student_app_ruff/constants/constants.dart';
import 'package:student_app_ruff/model/delete_all_model.dart';
import 'package:student_app_ruff/services/prefs_manager.dart';

class DeleteAllStudentsService {
  Future<DeleteAllModel?> deleteAll(BuildContext context,
      {required String userId}) async {
    try {
      final token = await PrefsManager().getToken();
      const url = "http://${Constants.ipAddress}:3000/student/";
      final response = await http.delete(
          Uri.parse(url).replace(queryParameters: {"userId": userId}),
          headers: {"Authorization": "Bearer $token"});
      final data = json.decode(response.body);

      if (response.statusCode == 200) {
        return DeleteAllModel.fromJson(data);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
