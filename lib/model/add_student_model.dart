class AddStudentPostModel {
  String name;
  String age;
  String domain;
  String gender;

  AddStudentPostModel({
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

class AddStudentResponseModel {
  bool success;
  Data data;

  AddStudentResponseModel({
    required this.success,
    required this.data,
  });

  factory AddStudentResponseModel.fromJson(Map<String, dynamic> json) =>
      AddStudentResponseModel(
        success: json["success"],
        data: Data.fromJson(json["data"]),
      );
}

class Data {
  String name;
  String age;
  String domain;
  String gender;

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
