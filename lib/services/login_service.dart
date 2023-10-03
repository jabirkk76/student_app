// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:student_app/model/login_model.dart';

import 'prefs_manager.dart';

class LoginService {
  Future<(String?, LoginResponseModel?)> Login(
      {required LoginPostModel loginPostModel}) async {
    try {
      const url = "https://std-app-server.onrender.com/user/signin/";
      final response = await http.post(
        Uri.parse(url),
        body: json.encode(
          json.decode(
            json.encode(loginPostModel.toJson()),
          ),
        ),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      );
      final data = json.decode(response.body);
      if (data['success'] == true) {
        final token = data['token'];
        await PrefsManager().storeToken(token);
        return (null, LoginResponseModel.fromJson(data));
      } else {
        return ('Failed to fetch login details', null);
      }
    } catch (e) {
      return ('Something went wrong', null);
    }
  }
}
