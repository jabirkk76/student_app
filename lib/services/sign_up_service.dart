import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:student_app_ruff/constants/constants.dart';
import 'package:student_app_ruff/model/sign_up_model.dart';

class SignUpService {
  Future<SignUpResponseModel?> signUp(
      {required SignUpPostModel signUpPostModel}) async {
    try {
      const url = "http://${Constants.ipAddress}:3000/user/signup/";
      final response = await http.post(
        Uri.parse(url),
        body: json.encode(
          json.decode(
            json.encode(signUpPostModel.toJson()),
          ),
        ),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        },
      );
      final data = json.decode(response.body);
      if (data['success'] == true) {
        return SignUpResponseModel.fromJson(data);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
