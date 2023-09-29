class StudentDetailModel {
  bool success;
  Student student;

  StudentDetailModel({
    required this.success,
    required this.student,
  });

  factory StudentDetailModel.fromJson(Map<String, dynamic> json) =>
      StudentDetailModel(
        success: json["success"],
        student: Student.fromJson(json["student"]),
      );
}

class Student {
  String name;
  int age;
  String domain;
  String gender;
  String id;

  Student({
    required this.name,
    required this.age,
    required this.domain,
    required this.gender,
    required this.id,
  });

  factory Student.fromJson(Map<String, dynamic> json) => Student(
        name: json["name"],
        age: json["age"],
        domain: json["domain"],
        gender: json["gender"],
        id: json["_id"],
      );
}
