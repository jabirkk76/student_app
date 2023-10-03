class LoginPostModel {
  String userEmail;
  String userPassword;

  LoginPostModel({
    required this.userEmail,
    required this.userPassword,
  });

  Map<String, dynamic> toJson() => {
        "email": userEmail,
        "password": userPassword,
      };
}

class LoginResponseModel {
  bool success;
  Data data;
  String token;

  LoginResponseModel({
    required this.success,
    required this.data,
    required this.token,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) =>
      LoginResponseModel(
        success: json["success"],
        data: Data.fromJson(json["data"]),
        token: json["token"],
      );
}

class Data {
  String id;
  String username;
  String email;
  String password;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  Data({
    required this.id,
    required this.username,
    required this.email,
    required this.password,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["_id"],
        username: json["username"],
        email: json["email"],
        password: json["password"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );
}
