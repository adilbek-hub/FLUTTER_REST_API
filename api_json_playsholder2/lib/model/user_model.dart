import 'dart:convert';

List<UsersModel> userModelFromJson(String str) =>
    List<UsersModel>.from(json.decode(str).map((x) => UsersModel.fromJson(x)));

String userModelToJson(List<UsersModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UsersModel {
  int userId;
  int id;
  String title;
  String body;

  UsersModel({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  factory UsersModel.fromJson(Map<String, dynamic> json) => UsersModel(
        userId: json["userId"],
        id: json["id"],
        title: json["title"],
        body: json["body"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "id": id,
        "title": title,
        "body": body,
      };
}
