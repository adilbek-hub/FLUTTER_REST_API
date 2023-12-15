import 'dart:convert';

//Бул userModelFromJson функциясы JSON форматындагы маалыматтарды камтыган str сабын алат.
List<PostsModel> postModelFromJson(String str) =>
//Ал алгач JSON сапты Dart объектине айландыруу үчүн json.decode(str) колдонот.
//Андан кийин ал PostsModel.fromJson функциясын тизменин ар бир элементине колдонуу үчүн
//картаны колдонот жана PostsModel объекттеринин жаңы тизмесин кайтарат.
    List<PostsModel>.from(
        json.decode(str).map((element) => PostsModel.fromJson(element)));

String userModelToJson(List<PostsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PostsModel {
  int userId;
  int id;
  String title;
  String body;

  PostsModel({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  factory PostsModel.fromJson(Map<String, dynamic> json) => PostsModel(
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
