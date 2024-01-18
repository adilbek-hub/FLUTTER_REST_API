import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_app_free2/features/data/model.dart';

import '../../constants/api_const.dart';

class DataRepo {
  Future<NewsModel?> fetchData() async {
    try {
      final response = await http.get(Uri.parse(ApiConst.newsApi));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final topNews = NewsModel.fromJson(data);
        return topNews;
      }
    } catch (e) {
      print(e.toString());
    }
    return null;
  }
}
