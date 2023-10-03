class SignUpPostModel {
  String username;
  String email;
  String password;

  SignUpPostModel({
    required this.username,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() => {
        "username": username,
        "email": email,
        "password": password,
      };
}

class SignUpResponseModel {
  bool success;
  Data data;
  String token;

  SignUpResponseModel({
    required this.success,
    required this.data,
    required this.token,
  });

  factory SignUpResponseModel.fromJson(Map<String, dynamic> json) =>
      SignUpResponseModel(
        success: json["success"],
        data: Data.fromJson(json["data"]),
        token: json["token"],
      );
}

class Data {
  String username;
  String email;
  String password;
  String id;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  Data({
    required this.username,
    required this.email,
    required this.password,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        username: json["username"],
        email: json["email"],
        password: json["password"],
        id: json["_id"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );
}
