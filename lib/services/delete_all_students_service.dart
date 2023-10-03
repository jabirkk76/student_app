import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import 'package:student_app/model/delete_all_model.dart';

import 'prefs_manager.dart';

class DeleteAllStudentsService {
  Future<(String?, DeleteAllModel?)> deleteAll(BuildContext context,
      {required String userId}) async {
    try {
      final token = await PrefsManager().getToken();
      const url = "https://std-app-server.onrender.com/student/";
      final response = await http.delete(Uri.parse(url),
          headers: {"Authorization": "Bearer $token"},
          body: {"userId": userId});
      final data = json.decode(response.body);

      if (response.statusCode == 200) {
        return (null, DeleteAllModel.fromJson(data));
      } else {
        return ('Failed fetching data', null);
      }
    } catch (e) {
      return ('Something went wrong', null);
    }
  }
}
