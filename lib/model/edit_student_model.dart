class EditStudentPostModel {
  String name;
  String age;
  String domain;
  String gender;

  EditStudentPostModel({
    required this.name,
    required this.age,
    required this.domain,
    required this.gender,
  });

  Map<String, dynamic> toJson() => {
        "name": name,
        "age": age,
        "domain": domain,
        "gender": gender,
      };
}

class EditStudentResponseModel {
  bool success;
  Data data;

  EditStudentResponseModel({
    required this.success,
    required this.data,
  });

  factory EditStudentResponseModel.fromJson(Map<String, dynamic> json) =>
      EditStudentResponseModel(
        success: json["success"],
        data: Data.fromJson(json["data"]),
      );
}

class Data {
  String? name;
  String? age;
  String? domain;
  String? gender;

  Data({
    required this.name,
    required this.age,
    required this.domain,
    required this.gender,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        name: json["name"],
        age: json["age"],
        domain: json["domain"],
        gender: json["gender"],
      );
}
