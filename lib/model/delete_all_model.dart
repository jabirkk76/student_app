class DeleteAllModel {
  bool success;
  String message;

  DeleteAllModel({
    required this.success,
    required this.message,
  });

  factory DeleteAllModel.fromJson(Map<String, dynamic> json) => DeleteAllModel(
        success: json["success"],
        message: json["message"],
      );
}
