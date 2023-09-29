// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:student_app_ruff/constants/constants.dart';
import 'package:student_app_ruff/model/login_model.dart';
import 'package:student_app_ruff/services/prefs_manager.dart';

class LoginService {
  Future<LoginResponseModel?> Login(
      {required LoginPostModel loginPostModel}) async {
    try {
      const url = "http://${Constants.ipAddress}:3000/user/signin/";
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
      print(response.body);
      if (data['success'] == true) {
        final token = data['token'];
        await PrefsManager().storeToken(token);
        return LoginResponseModel.fromJson(data);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
