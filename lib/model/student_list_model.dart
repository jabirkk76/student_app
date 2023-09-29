class StudentModel {
  String name;
  int age;
  String domain;
  String gender;
  String? id;

  StudentModel({
    required this.name,
    required this.age,
    required this.domain,
    required this.gender,
    this.id,
  });

  factory StudentModel.fromJson(Map<String, dynamic> json) => StudentModel(
        name: json["name"],
        age: json["age"],
        domain: json["domain"],
        gender: json["gender"],
        id: json["_id"],
      );
}
