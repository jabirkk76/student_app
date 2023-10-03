class AddStudentPostModel {
  String name;
  String age;
  String domain;
  String gender;
  String userId;

  AddStudentPostModel(
      {required this.name,
      required this.age,
      required this.domain,
      required this.gender,
      required this.userId});

  Map<String, dynamic> toJson() => {
        "name": name,
        "age": age,
        "domain": domain,
        "gender": gender,
        "userId": userId
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
  int age;
  String domain;
  String gender;
  String userId;
  String id;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  Data({
    required this.name,
    required this.age,
    required this.domain,
    required this.gender,
    required this.userId,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        name: json["name"],
        age: json["age"],
        domain: json["domain"],
        gender: json["gender"],
        userId: json["userId"],
        id: json["_id"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );
}
