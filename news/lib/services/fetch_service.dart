import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news/constants/api_const.dart';
import 'package:news/model/top_news.dart';

class TopNewsRepo {
  final http.Client client = http.Client();
  Future<TopNews?> fetchTopNews([String? domain]) async {
    final Uri uri = Uri.parse(ApiConst.topNews(domain));
    final http.Response response = await client.get(uri);
    if (response.statusCode == 200 || response.statusCode == 201) {
      print(response.body);
      print('-------------------------------');
      print(response.body.runtimeType);
      print('-------------------------------');
      final data = jsonDecode(response.body);

      print(data.runtimeType);
      print('-------------------------------');
      final topNews = TopNews.fromJson(data);
      print(topNews);
      return topNews;
    }
    return null;
  }
}
