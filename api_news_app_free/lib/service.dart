import 'dart:convert';

import 'package:api_news_app_free/api_const.dart';
import 'package:api_news_app_free/model/top_news.dart';
import 'package:http/http.dart' as http;

class TopNewsRepo {
  final http.Client client = http.Client();
  Future<TopNews?> fetchData() async {
    final Uri uri = Uri.parse(ApiConst.topNews);
    final http.Response response = await client.get(uri);
    if (response.statusCode == 200 || response.statusCode == 201) {
      print(response.body.runtimeType);
      final data = jsonDecode(response.body);
      print(data.runtimeType);
      final topNews = TopNews.fromJson(data);
      print(topNews.runtimeType);
      return topNews;
    }
    return null;
  }
}
