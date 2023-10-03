import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:student_app/model/sign_up_model.dart';

class SignUpService {
  Future<(String?, SignUpResponseModel?)> signUp(
      {required SignUpPostModel signUpPostModel}) async {
    try {
      const url = "https://std-app-server.onrender.com/user/signup/";
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
        return (null, SignUpResponseModel.fromJson(data));
      } else {
        return ('Failed to Sign up', null);
      }
    } catch (e) {
      return ('Something went wrong', null);
    }
  }
}
