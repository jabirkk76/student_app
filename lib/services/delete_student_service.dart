// ignore_for_file: use_build_context_synchronously, unused_local_variable

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import 'prefs_manager.dart';

class DeleteStudentService {
  Future<(String?, bool)> delete(BuildContext context,
      {required String userId, required String studentId}) async {
    try {
      final token = await PrefsManager().getToken();
      final url = 'https://std-app-server.onrender.com/student/$userId';
      final response = await http.delete(Uri.parse(url),
          headers: {"Authorization": "Bearer $token"},
          body: {"studentId": studentId});

      if (response.statusCode == 204) {
        return (null, true);
      } else {
        return ('Failed to fetch details', false);
      }
    } catch (e) {
      return ('Something went wrong', false);
    }
  }
}
