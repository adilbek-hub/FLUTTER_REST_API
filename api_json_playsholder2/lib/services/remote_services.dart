import 'package:api_json_playsholder2/api_const.dart';
import 'package:api_json_playsholder2/model/photos_model.dart';
import 'package:api_json_playsholder2/model/post_model.dart';
import 'package:api_json_playsholder2/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RemoteServices {
  final http.Client client = http.Client();
  Future<List<PostsModel>?> fetchData() async {
    final Uri uri = Uri.parse(ApiConst.apiPosts);
    final http.Response response = await http.get(uri);
    if (response.statusCode == 200 || response.statusCode == 201) {
      final json = response.body;
      return postModelFromJson(json);
    } else {
      return null;
    }
  }

////////////////////////////////////////////////////////////////////////////////////
  Future<List<UsersModel>?> userFromJson() async {
    final Uri uri = Uri.parse(ApiConst.apiUsers);
    final http.Response response = await http.get(uri);
    if (response.statusCode == 200 || response.statusCode == 201) {
      final json = response.body;
      print(json);
      return userModelFromJson(json);
    }
    return null;
  }

  ////////////////////////////////////////////////////////////////////////////////////
  Future<List<PhotoModel>?> photosFromJson() async {
    final Uri uri = Uri.parse(ApiConst.apiPhotos);
    final http.Response response = await http.get(uri);
    if (response.statusCode == 200 || response.statusCode == 201) {
      final json = response.body;
      print(json);
      return photoModelFromJson(json);
    }
    return null;
  }
}
